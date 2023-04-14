//===---- EquivalenceClasses.h - Reduce the CFG for Single-Path code ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//
#ifndef TARGET_PATMOS_SINGLEPATH_EQUIVALENCECLASSES_H_
#define TARGET_PATMOS_SINGLEPATH_EQUIVALENCECLASSES_H_

#include "llvm/CodeGen/MachineFunctionPass.h"

#include <set>

namespace llvm {

	// Represents an equivalence class
	struct EqClass {
		/// The unique number assigned to this class
		unsigned number;

		/// The edges the block is control dependent on
		std::set<Optional<std::pair<MachineBasicBlock*,MachineBasicBlock*>>> dependencies;

		// The blocks within the class
		std::set<MachineBasicBlock*> members;
	};

	class EquivalenceClasses : public MachineFunctionPass {
	private:
		std::map<
			// Unique number of the class
			unsigned,
			std::pair<
				// The control dependencies of the class
				// 'None' defines the entry of the function, while 'Some' is an edge
				std::set<Optional<std::pair<MachineBasicBlock*,MachineBasicBlock*>>>,
				// The blocks in the class
				std::set<MachineBasicBlock*>
			>
		> classes;

	public:
		static char ID;

		EquivalenceClasses() :
			MachineFunctionPass(ID)
		{}

		StringRef getPassName() const override {
			return "Patmos Single-Path Equivalence Classes";
		}

		void getAnalysisUsage(AnalysisUsage &AU) const override {
			MachineFunctionPass::getAnalysisUsage(AU);
		}

		bool runOnMachineFunction(MachineFunction &MF) override;


		std::vector<EqClass> getAllClasses() const;

		EqClass getClassFor(MachineBasicBlock*mbb) const;
	};
}

#endif /* TARGET_PATMOS_SINGLEPATH_EQUIVALENCECLASSES_H_ */
