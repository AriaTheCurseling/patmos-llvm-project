#include "gtest/gtest.h"
#include "gmock/gmock.h"
#include "SinglePath/SPListScheduler.h"
#include "llvm/ADT/SmallVector.h"
#include <set>

using namespace llvm;

using ::testing::Return;
using ::testing::Contains;
using ::testing::SizeIs;
using ::testing::UnorderedElementsAreArray;
using ::testing::Eq;

namespace llvm{
  enum Operand {
    R0=0,
    R1=1,
    R2=2,
    R3=3,
    R4=4,
  };

  /// Various attributes of an instruction
  class InstrAttr {
  public:
	/// Whether the outputs are poisoned until they are ready.
	/// If latency is 0, has no effect.
	/// Otherwise, if true, while the instruction is executing the writes of the instruction
	/// cannot be read/written by any other instruction
	bool poisons;

	/// If true, this instruction performs a memory access (either read or write), otherwise not.
	bool memory_access;

	/// How many cycles it takes to execute the instruction.
	/// 0 means the result is ready in the following cycles.
	/// 1 means 1 cycles must be skipped before the result is ready
	unsigned latency;

	/// Whether this instruction is a conditional branch out of the MBB
	bool conditional_branch;

	/// Whether this instruction is allowed to be scheduled in the second issue slot
	bool may_second_slot;

	/// Whether this instruction is long (takes up both issue slots, 8 bytes)
	bool is_long;

	/// Whether this instruction is a call instruction
	bool is_call;

    /// If true, instruction may not be bundled with other instructions that also
    /// have this field set.
    bool non_bundleable;

	InstrAttr( unsigned latency, bool poisons, bool memory_access,
			bool conditional_branch, bool may_second_slot, bool is_long,
			bool is_call, bool nonBundleable
	): poisons(poisons), memory_access(memory_access), latency(latency),
	  conditional_branch(conditional_branch), may_second_slot(may_second_slot),
	  is_long(is_long), is_call(is_call), non_bundleable(nonBundleable)
	{}

	/// Instruction with default attributes similar to simple ALU instructions
	static InstrAttr simple(unsigned latency=0){
	  return InstrAttr(latency,false,false,false,true,false,false,false);
	}

	/// Similar to `simple()` except cannot be in second issue slot
	static InstrAttr simple_first_only(unsigned latency=0){
	  auto simple = InstrAttr::simple(latency);
	  simple.may_second_slot = false;
	  return simple;
	}

	/// Similar to `simple()` except may not be bundled
	static InstrAttr simple_non_bundleable(unsigned latency=0){
	  auto simple = InstrAttr::simple(latency);
	  simple.non_bundleable = true;
	  return simple;
	}

	/// Similar to `simple()` except is a long instruction
	static InstrAttr simple_long(unsigned latency=0){
	  auto simple = InstrAttr::simple_first_only(latency);
	  simple.is_long = true;
	  return simple;
	}

	/// Similar to `simple()` except poisons outputs
	static InstrAttr poison(unsigned latency){
	  auto simple = InstrAttr::simple(latency);
	  simple.poisons = true;
	  return simple;
	}

	/// Similar to `load()` except doesn't poison and with given latency
	static InstrAttr mem_acc(unsigned latency){
	  return InstrAttr(latency,false,true,false,false,false,false,false);
	}

	/// Like Patmos load instruction
	static InstrAttr load(){
	  return InstrAttr(1,true,true,false,false,false,false,false);
	}

	/// Like Patmos branch instructions (with optional latency)
	static InstrAttr branch(unsigned latency=0){
	  return InstrAttr(latency,false,false,true,false,false,false,false);
	}

	/// Like Patmos branch instructions (with optional latency)
	static InstrAttr call(){
	  return InstrAttr(0,false,false,false,false,false,true,false);
	}
  };

  class MockInstr {
  public:
    /// Set of operands this instruction reads.
    std::set<Operand> reads;

    /// Set of operands this instruction writes.
    std::set<Operand> writes;

    InstrAttr attr;

    MockInstr(std::set<Operand> reads, std::set<Operand> writes, InstrAttr attr):
      reads(reads), writes(writes), attr(attr)
    {}

    bool is_read(Operand r) {
      return reads.count(r);
    }

    bool is_written(Operand r) {
      return writes.count(r);
    }

    static MockInstr nop(){
      return MockInstr({},{},InstrAttr::simple());
    }

    bool isCall() const {
    	return attr.is_call;
    }
  };

  bool is_constant(Operand p) {
    return p == Operand::R0;
  }

  std::set<Operand> reads(const MockInstr* instr) {
    return instr->reads;
  }

  std::set<Operand> writes(const MockInstr* instr) {
    return instr->writes;
  }

  bool poisons(const MockInstr* instr) {
    return instr->attr.poisons;
  }

  bool memory_access(const MockInstr* instr) {
    return instr->attr.memory_access;
  }

  unsigned latency(const MockInstr* instr) {
    return instr->attr.latency;
  }

  bool conditional_branch(const MockInstr* instr) {
    return instr->attr.conditional_branch;
  }

  bool may_second_slot(void*, const MockInstr* instr) {
    return instr->attr.may_second_slot;
  }

  bool is_long(const MockInstr* instr) {
    return instr->attr.is_long;
  }

  bool may_bundle(const MockInstr* instr1, const MockInstr* instr2) {
	  return !(instr1->attr.non_bundleable && instr2->attr.non_bundleable);
  }

  llvm::Optional<std::tuple<
      void*,
      bool (*)(void*, const MockInstr *),
      bool (*)(const MockInstr *),
      bool (*)(const MockInstr *, const MockInstr *)
    >> disable_dual_issue = None;
  llvm::Optional<std::tuple<
      void*,
      bool (*)(void*, const MockInstr *),
      bool (*)(const MockInstr *),
      bool (*)(const MockInstr *, const MockInstr *)
    >> enable_dual_issue = std::make_tuple((void*)nullptr, may_second_slot, is_long, may_bundle);

  class MockMBB {
  public:
    // We use pointers to vectors because using vectors directly always
    // resulted in segmentation fault. Don't know why. This is a workaround.
    SmallVector<MockInstr> *instructions;

    MockMBB(SmallVector<MockInstr> *instructions) : instructions(instructions) {
    }

    typename SmallVector<MockInstr>::const_iterator begin() const {
      return instructions->begin();
    }
    typename SmallVector<MockInstr>::const_iterator end() const {
      return instructions->end();
    }
    unsigned size() const {
      return instructions->size();
    }

  };
}

namespace {

#define pair(p1,p2) std::make_pair(p1,p2)
#define block(name, instrs) \
  SmallVector<MockInstr> name ## _instructions = instrs; \
  MockMBB name(&name ## _instructions);
/// Used to protect literal arrays from the preprocessor.
/// see https://stackoverflow.com/questions/5503362/passing-array-literal-as-macro-argument
#define arr(...) __VA_ARGS__

TEST(ListSchedulerTest, UnrelatedInstructions){
  /* Tests that when no dependencies occur, the order the instructions come in is maintained
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
        pair(2, 2),
        pair(3, 3),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
        pair(2, 2),
        pair(3, 3),
      })
  );
}

TEST(ListSchedulerTest, PoisonAddsNop){
  /* Tests that a nop is added in delay slots if nothing else can be put there.
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::poison(2)),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(3, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(6, 1),
      })
  );
}

TEST(ListSchedulerTest, DelayAddsNop){
  /* Tests that a nop is added in delay slots if nothing else can be put there.
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::simple(1)),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(4, 1),
      })
  );
}

TEST(ListSchedulerTest, FillDelay){
  /* Tests that an unrelated instruction is put in delay slots
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::poison(1)),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(1, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(4, 1),
        pair(1, 2),
      })
  );
}

TEST(ListSchedulerTest, PreferLongDelay){
  /* Tests if multiple instruction are available and unrelated, the one with the longest delay
   * is chosen first
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple(1)),
    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple(2)),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(2, 0),
        pair(1, 1),
        pair(0, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(2, 0),
        pair(1, 1),
        pair(0, 2),
      })
  );
}

TEST(ListSchedulerTest, MaintainMemAccessOrder){
  /* Tests instructions accessing memory aren't reordered, even if they could have been otherwise.
   *
   * Here, all instructions access memory. The second uses the output of the first. but the third
   * is unrelated to both.
   * If the third wasn't a memory access, it would have been scheduled between the first and second.
   * However, in this case it must stay as the third
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::mem_acc(1)),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::mem_acc(0)),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::mem_acc(0)),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(3, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(4, 1),
        pair(6, 2),
      })
  );
}

TEST(ListSchedulerTest, ConstantsCantPoison){
  /* Tests that constants can't be poisoned
   */
  block(mockMBB, arr({
    MockInstr({Operand::R1},{Operand::R0},InstrAttr::poison(1)),
    MockInstr({Operand::R0},{Operand::R2},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
      })
  );
}

TEST(ListSchedulerTest, ConstantsDontDelay){
  /* Tests that writing to a constant with delay doesn't incur the delay from users of the constant
   */
  block(mockMBB, arr({
    MockInstr({Operand::R1},{Operand::R0},InstrAttr::simple(2)),
    MockInstr({Operand::R0},{Operand::R2},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
      })
  );
}

TEST(ListSchedulerTest, ConstantsDontMakeDependence){
  /* Tests that instruction reading/writing to a constant can be reordered
   */
  block(mockMBB, arr({
    MockInstr({Operand::R1},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R0},{Operand::R2},InstrAttr::simple(2)),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(0, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(0, 1),
      })
  );
}

TEST(ListSchedulerTest, WeakDepInDelay){
  /* Test that a weak dependency on a delayed instruction can be scheduled in the delay slot
   */
  block(mockMBB, arr({
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::load()),
    MockInstr({Operand::R2, Operand::R1},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R0},{Operand::R4},InstrAttr::load()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(1, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(4, 1),
        pair(2, 2),
      })
  );
}

TEST(ListSchedulerTest, Branch){
  /* Tests a branch instruction disallows following instruction to be moved before it
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple(3)),
    MockInstr({Operand::R1},{},InstrAttr::branch()),
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple(4)),
    MockInstr({Operand::R4},{Operand::R4},InstrAttr::simple()),
    MockInstr({Operand::R3},{},InstrAttr::branch()),
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple()),
    MockInstr({Operand::R4},{Operand::R4},InstrAttr::simple())
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
        pair(5, 2),
        pair(7, 3),
        pair(6, 4),
        pair(8, 5),
        pair(11, 6),
        pair(12, 7),
        pair(13, 8),
        pair(14, 9),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(10, 2),
        pair(13, 3),
        pair(12, 4),
        pair(14, 5),
        pair(22, 6),
        pair(24, 7),
        pair(25, 8),
        pair(26, 9),
      })
  );
}

TEST(ListSchedulerTest, WritesToSameArentReordered){
  /* Tests that instructions that write to the same operand aren't reordered, even if
   * it results in an unused delay slot
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::load()),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R2},InstrAttr::simple())
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(3, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(4, 1),
        pair(6, 2),
      })
  );
}

TEST(ListSchedulerTest, NoLongInSecondIssue){
  /* Tests that a long instruction cannot be in the second issue slot and that
   * another instruction can't be scheduled in its second issue slot
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R0},InstrAttr::simple(2)),
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::simple_long()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(2, 0),
        pair(0, 1),
        pair(3, 2),
        pair(4, 3),
      })
  );
}

TEST(ListSchedulerTest, IneligibleSecondSlot){
  /* Tests that a short instruction that is ineligible for the second issue slot
   * gets scheduled in the first.
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple_first_only()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(0, 1),
      })
  );
}

TEST(ListSchedulerTest, FinalBranch){
  /* Tests that when branch doesn't directly depend of previous instructions,
   * and other factors make it prioritised if it wasn't a branch, it would still
   * not be moved above instruction the was above it to begin with.
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R2},{Operand::R2},InstrAttr::simple()),
    // We give the branch a high latency so that it would have been prioritised
    // if it wasn't for the fact that it is a branch too.
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::branch(4)),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
        pair(2, 2),
        pair(3, 3),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
        pair(3, 2),
        pair(2, 3),
      })
  );
}

TEST(ListSchedulerTest, MultipleReadersBeforeWrite){
  /* Tests that when a write is preceded by multiple reads, the write cannot be
   * move above any of the reads
   */
  block(mockMBB, arr({
    MockInstr({Operand::R3},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R0},InstrAttr::simple()),
    MockInstr({Operand::R3},{Operand::R0},InstrAttr::simple()),
    // We give the last read a latency of 1 so that it is move above the other reads
    // If the schedule only tracks 1 read (the last), it would then move the write
    // above the other reads (which it shouldn't).
    MockInstr({Operand::R3},{Operand::R0},InstrAttr::simple(1)),
    // We give the write high latency to give check that it doesn't move above
    // the reads anyway
    MockInstr({Operand::R4},{Operand::R3},InstrAttr::simple(4)),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(2, 1),
        pair(3, 2),
        pair(0, 3),
        pair(4, 4),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(2, 1),
        pair(3, 2),
        pair(0, 3),
        pair(4, 4),
      })
  );
}

TEST(ListSchedulerTest, CanFlipBundle){
  /* Tests that if a bundle's first slot is occupied and the next
   * ready instruction has to be in the first slot (and is short) then it second
   * instruction gets the first slot and the other gets the second
   */
  block(mockMBB, arr({
    // Use high latency to ensure this get scheduled first
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple(1)),
    // Must be in first slot but is otherwise not priority
    MockInstr({Operand::R3},{Operand::R4},InstrAttr::simple_first_only()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(0, 1),
      })
  );
}

TEST(ListSchedulerTest, CanFlipBundleAntiDep){
  /* Tests that if a write to an operand comes after a read, they can be scheduled
   * together even when the write instruction must be in  the first slot.
   */
  block(mockMBB, arr({
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple()),
    // Must be in first slot and writes to the read
    MockInstr({Operand::R3},{Operand::R1},InstrAttr::simple_first_only()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(1, 0),
        pair(0, 1),
      })
  );
}

TEST(ListSchedulerTest, BundleWriteWithRead){
  /* Tests that a write of an operand can be bundled with a preceding read
   * (since the write writes back to the register after the register is read)
   */
  block(mockMBB, arr({
    // Use high latency to ensure this get scheduled first
    MockInstr({Operand::R3},{Operand::R2},InstrAttr::simple()),
    // Must be in first slot but is otherwise not priority
    MockInstr({Operand::R3},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(1, 1),
      })
  );
}

TEST(ListSchedulerTest, Call){
  /* Test calls aren't reordered with their calling convention inputs.
   * They are allowed to be bundled with instructions outputting
   * registers from the calling convention
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple()),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
		pair(2, 2),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(1, 0),
		pair(0, 1),
		pair(2, 2),
      })
  );
}

TEST(ListSchedulerTest, BundleCallWithSucc){
  /* Tests can take an instruction that follows a call and bundles it with the call
   * as long as it doesn't write or read from registers the call does
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple()),
		MockInstr({},{Operand::R1},InstrAttr::simple()),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({},{Operand::R4},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
		pair(2, 2),
		pair(3, 3),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
		pair(2, 2),
		pair(3, 3),
      })
  );
}

TEST(ListSchedulerTest, NotBundleCallWithReadSucc){
  /*
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple()),
		MockInstr({},{Operand::R1},InstrAttr::simple()),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({},{Operand::R3},InstrAttr::simple()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
		pair(2, 2),
		pair(4, 3),
      })
  );
}

TEST(ListSchedulerTest, CallInputLatency){
  /* Tests that if an instruction writes to a register a call uses with a latency,
   * the call must delay until the latency is over.
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple(1)),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({},{Operand::R4},InstrAttr::simple()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(2, 1),
		pair(1, 2),
      })
  );

  block(mockMBB2, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple(3)),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({},{Operand::R4},InstrAttr::simple()),
  }));

  auto new_schedule = list_schedule(mockMBB2.begin(), mockMBB2.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(3, 1),
		pair(1, 2),
      })
  );

  auto new_schedule3 = list_schedule(mockMBB2.begin(), mockMBB2.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule3,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(6, 1),
		pair(1, 2),
      })
  );
}

TEST(ListSchedulerTest, NotBundleCallWithWriteSucc){
  /* Tests that if an instruction reads from a register that a preceding call writes to
   * it cannot be bundled with the call
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R2},{Operand::R3},InstrAttr::simple()),
		MockInstr({},{Operand::R1},InstrAttr::simple()),
	    MockInstr({Operand::R3},{Operand::R1},InstrAttr::call()),
	    MockInstr({Operand::R1},{},InstrAttr::simple()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
		pair(2, 2),
		pair(4, 3),
      })
  );
}

TEST(ListSchedulerTest, CallPoison){
  /* Test that call instruction doesn't need its reads/writes to be fully unpoisoned
   * (they may have 1 poison cycle left)
   */
  block(mockMBB, arr({
	    MockInstr({Operand::R3},{Operand::R3},InstrAttr::poison(1)),
	    MockInstr({Operand::R3},{Operand::R3},InstrAttr::call()),
  }));

  auto new_schedule = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, disable_dual_issue);

  EXPECT_THAT(
      new_schedule,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(1, 1),
      })
  );

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
		pair(2, 1),
      })
  );
}

TEST(ListSchedulerTest, non_bundleable){
  /* Tests that two instruction marked as not mutually bundleable, aren't bundle together
   */
  block(mockMBB, arr({
    MockInstr({Operand::R0},{Operand::R1},InstrAttr::simple()),
    MockInstr({Operand::R1},{Operand::R2},InstrAttr::simple_non_bundleable()),
    MockInstr({Operand::R1},{Operand::R3},InstrAttr::simple_non_bundleable()),
    MockInstr({Operand::R2,Operand::R3},{Operand::R4},InstrAttr::simple()),
  }));

  auto new_schedule2 = list_schedule(mockMBB.begin(), mockMBB.end(),
      reads, writes, poisons, memory_access, latency, is_constant, conditional_branch, enable_dual_issue);

  EXPECT_THAT(
      new_schedule2,
      UnorderedElementsAreArray({
        pair(0, 0),
        pair(2, 1),
        pair(4, 2),
        pair(6, 3),
      })
  );
}

}
