//==-- PatmosSinglePathInfo.cpp - Analysis Pass for SP CodeGen -----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===---------------------------------------------------------------------===//
//
// This file defines a pass to compute imformation for single-path converting
// seleced functions.
//
//===---------------------------------------------------------------------===//

#define DEBUG_TYPE "patmos-singlepath"

#include "Patmos.h"
#include "PatmosInstrInfo.h"
#include "PatmosTargetMachine.h"
#include "llvm/Function.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/MachinePostDominators.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

#include "PatmosSinglePathInfo.h"

#include <map>
#include <queue>


using namespace llvm;


/// SPFuncList - Option to enable single-path conversion.
static cl::list<std::string> SPFuncList(
    "mpatmos-spconv",
    cl::value_desc("list"),
    cl::desc("A list of functions to Single-Path convert (Patmos only)"),
    cl::CommaSeparated,
    cl::Hidden);


///////////////////////////////////////////////////////////////////////////////

char PatmosSinglePathInfo::ID = 0;

/// createPatmosSinglePathInfoPass - Returns a new PatmosSinglePathInfo pass
/// \see PatmosSinglePathInfo
FunctionPass *
llvm::createPatmosSinglePathInfoPass(const PatmosTargetMachine &tm) {
  return new PatmosSinglePathInfo(tm);
}

///////////////////////////////////////////////////////////////////////////////


bool PatmosSinglePathInfo::isEnabled() {
  return !SPFuncList.empty();
}



PatmosSinglePathInfo::PatmosSinglePathInfo(const PatmosTargetMachine &tm)
  : MachineFunctionPass(ID), TM(tm),
    STC(tm.getSubtarget<PatmosSubtarget>()),
    TII(static_cast<const PatmosInstrInfo*>(tm.getInstrInfo())),
    Funcs(SPFuncList.begin(), SPFuncList.end()), Root(0)   {}


bool PatmosSinglePathInfo::doInitialization(Module &M) {
  // fill the set of functions to convert as specified on command line
  FuncsRemain.insert( Funcs.begin(), Funcs.end() );
  return false;
}


bool PatmosSinglePathInfo::doFinalization(Module &M) {
  if (!FuncsRemain.empty()) {
    DEBUG( dbgs() << "Following functions not found to "
                     "single-path convert:\n'" );
    for (std::set<std::string>::iterator it=FuncsRemain.begin();
            it!=FuncsRemain.end(); ++it) {
      DEBUG( dbgs() << *it << "' ");
    }
    DEBUG( dbgs() << '\n');
    FuncsRemain.clear();
  }
  if (Root) {
    delete Root;
    Root = NULL;
  }
  return false;
}

void PatmosSinglePathInfo::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<MachinePostDominatorTree>();
  AU.addRequired<MachineLoopInfo>();
  AU.setPreservesAll();
  MachineFunctionPass::getAnalysisUsage(AU);
}

bool PatmosSinglePathInfo::runOnMachineFunction(MachineFunction &MF) {
  // clear the state of the pass
  PredCount = 0;
  PredUse.clear();
  PredDefsT.clear();
  PredDefsF.clear();
  PredEntryEdge.clear();
  if (Root) {
    delete Root;
    Root = NULL;
  }
  // only consider function if specified on command line
  std::string curfunc = MF.getFunction()->getName();
  if ( isToConvert(MF) ) {
    DEBUG( dbgs() << "[Single-Path] Analyze '" << curfunc << "'\n" );
    analyzeFunction(MF);
    FuncsRemain.erase(curfunc);
  }
  // didn't modify anything
  return false;
}


static void printBitVector(raw_ostream &OS, BitVector B) {
  for (int i=B.size()-1; i>=0; i--) {
    OS << ( (B.test(i)) ? "1" : "0" );
  }
}

void PatmosSinglePathInfo::print(raw_ostream &OS, const Module *M) const {
  // TODO implement
}


#if !defined(NDEBUG) || defined(LLVM_ENABLE_DUMP)
void PatmosSinglePathInfo::dump() const {
  print(dbgs());
}
#endif


bool PatmosSinglePathInfo::isToConvert(MachineFunction &MF) const {
  return Funcs.count(MF.getFunction()->getName()) > 0;
}


int PatmosSinglePathInfo::getPredUse(const MachineBasicBlock *MBB) const {
  if (PredUse.count(MBB)) {
    return PredUse.at(MBB);
  }
  return -1;
}

BitVector PatmosSinglePathInfo::getPredUseBV(const MachineBasicBlock *MBB)
                                                                    const {
  BitVector bv(PredCount);
  if (PredUse.count(MBB)) {
    bv.set(PredUse.at(MBB));
  }
  return bv;
}


BitVector PatmosSinglePathInfo::getPredDefsT(const MachineBasicBlock *MBB)
                                                                    const {
  if (PredDefsT.count(MBB)) {
    return PredDefsT.at(MBB);
  }
  return BitVector(PredCount);
}


BitVector PatmosSinglePathInfo::getPredDefsF(const MachineBasicBlock *MBB)
                                                                    const {
  if (PredDefsF.count(MBB)) {
    return PredDefsF.at(MBB);
  }
  return BitVector(PredCount);
}

BitVector PatmosSinglePathInfo::getPredDefsBoth(const MachineBasicBlock *MBB)
                                                                    const {
  BitVector bv(PredCount);
  if (PredDefsT.count(MBB)) { bv |= PredDefsT.at(MBB); }
  if (PredDefsF.count(MBB)) { bv |= PredDefsF.at(MBB); }
  return bv;
}

void PatmosSinglePathInfo::walkRoot(llvm::SPNodeWalker &walker) const {
  assert( Root != NULL );
  Root->walk(walker);
}


void PatmosSinglePathInfo::analyzeFunction(MachineFunction &MF) {

  Root = createSPNodeTree(MF);
  DEBUG( Root->dump() );


  // CD: MBB -> set of edges
  CD_map_t CD;
  computeControlDependence(MF, CD);

  // decompose CD
  K_t K;
  R_t R;
  decomposeControlDependence(MF, CD, K, R);


  // Properly assign the Uses/Defs
  PredCount = K.size();
  PredUse = R;
  // collect PredDefsT, PredDefsF
  collectPredDefs(MF, K);


  DEBUG_TRACE({
    dbgs() << "Number of predicates: " <<  PredCount << "\n";
    dbgs() << "Defs to T edges in " <<  PredDefsT.size() << " MBBs\n";
    dbgs() << "Defs to F edges in " <<  PredDefsF.size() << " MBBs\n";
    dbgs() << "Defs T on entry edge: ";
      printBitVector(dbgs(), PredEntryEdge);
      dbgs() << "\n";

    for (MachineFunction::const_iterator I = MF.begin(), E = MF.end();
              I!=E; ++I) {
      dbgs() << "MBB#" << I->getNumber() << ": use ";
      printBitVector(dbgs(), getPredUseBV(I));
      dbgs() << " defT ";
      printBitVector(dbgs(), getPredDefsT(I));
      dbgs() << " defF ";
      printBitVector(dbgs(), getPredDefsF(I));
      dbgs() << "\n";
    }
  });

  // XXX for debugging
  //MF.viewCFGOnly();

}



void PatmosSinglePathInfo::computeControlDependence(MachineFunction &MF,
                                                    CD_map_t &CD) const {
  // for CD, we need the Postdom-Tree
  MachinePostDominatorTree &PDT = getAnalysis<MachinePostDominatorTree>();
  assert(PDT.getRoots().size()==1 && "Function must have a single exit node!");

  DEBUG_TRACE( dbgs() << "Post-dominator tree:\n" );
  DEBUG_TRACE( PDT.print(dbgs(), MF.getFunction()->getParent()) );

  // build control dependence
  for (MachineFunction::iterator FI=MF.begin(), FE=MF.end(); FI!=FE; ++FI) {
    MachineBasicBlock *MBB = FI;
    MachineDomTreeNode *ipdom = PDT[MBB]->getIDom();

    for(MachineBasicBlock::succ_iterator SI=MBB->succ_begin(),
                                         SE=MBB->succ_end(); SI!=SE; ++SI) {
      MachineBasicBlock *SMBB = *SI;
      // exclude edges to post-dominaing successors
      if (!PDT.dominates(SMBB, MBB)) {
        // insert the edge MBB->SMBB to all controlled blocks
        for (MachineDomTreeNode *t = PDT[SMBB]; t != ipdom; t = t->getIDom()) {
          CD[t->getBlock()].insert( std::make_pair(MBB,SMBB) );
        }
      }
    } // end for all successors
  } // end for each MBB

  // add control dependence for entry edge NULL -> BB0
  {
    MachineBasicBlock *entryMBB = &MF.front();
    for (MachineDomTreeNode *t = PDT[entryMBB]; t != NULL; t = t->getIDom() ) {
      CD[t->getBlock()].insert( std::make_pair(
                                  (MachineBasicBlock*)NULL, entryMBB)
                                  );
    }
  }


  DEBUG_TRACE({
    // dump CD
    dbgs() << "Control dependence:\n";
    for (CD_map_t::iterator I=CD.begin(), E=CD.end(); I!=E; ++I) {
      dbgs() << "BB#" << I->first->getNumber() << ": { ";
      for (CD_map_entry_t::iterator EI=I->second.begin(), EE=I->second.end();
           EI!=EE; ++EI) {
        dbgs() << "(" << ((EI->first) ? EI->first->getNumber() : -1) << ","
                      << EI->second->getNumber() << "), ";
      }
      dbgs() << "}\n";
    }
  });
}



void PatmosSinglePathInfo::decomposeControlDependence(MachineFunction &MF,
                                                      const CD_map_t &CD,
                                                      K_t &K, R_t &R) const {
  int p = 0;
  for (MachineFunction::iterator FI=MF.begin(); FI!=MF.end(); ++FI) {
    MachineBasicBlock *MBB = FI;
    CD_map_entry_t t = CD.at(MBB);
    int q=-1;
    // try to lookup the control dependence
    for (unsigned int i=0; i<K.size(); i++) {
        if ( t == K[i] ) {
          q = i;
          break;
        }
    }
    if (q != -1) {
      // we already have handled this dependence
      R[MBB] = q;
    } else {
      // new dependence set:
      K.push_back(t);
      R[MBB] = p++;
    }
  } // end for each MBB

  DEBUG_TRACE({
    // dump R, K
    dbgs() << "Decomposed CD:\n";
    dbgs() << "map R: MBB -> pN\n";
    for (R_t::iterator RI=R.begin(), RE=R.end(); RI!=RE; ++RI) {
      dbgs() << "R(" << RI->first->getNumber() << ") = p" << RI->second << "\n";
    }
    dbgs() << "map K: pN -> t \\in CD\n";
    for (unsigned int i=0; i<K.size(); i++) {
      dbgs() << "K(p" << i << ") -> {";
      for (CD_map_entry_t::iterator EI=K[i].begin(), EE=K[i].end();
            EI!=EE; ++EI) {
        dbgs() << "(" << ((EI->first) ? EI->first->getNumber() : -1) << ","
                      << EI->second->getNumber() << "), ";
      }
      dbgs() << "}\n";
    }
  });
}


BitVector PatmosSinglePathInfo::getInitializees(const SPNode *N) const {
  BitVector bv(PredCount);
  for (unsigned i=1; i<N->Blocks.size(); i++) {
    bv.set(PredUse.at(N->Blocks[i]));
  }
  return bv;
}

void PatmosSinglePathInfo::collectPredDefs(MachineFunction &MF, const K_t &K) {
  // Initialize entry predicates
  PredEntryEdge = BitVector(PredCount);
  // For each predicate, compute defs
  for (unsigned int i=0; i<K.size(); i++) {
    // for each definition edge
    for (CD_map_entry_t::iterator EI=K[i].begin(), EE=K[i].end();
              EI!=EE; ++EI) {
      const MachineBasicBlock *MBBSrc = EI->first, *MBBDst = EI->second;
      if (!MBBSrc) {
        // top-level entry edge
        PredEntryEdge.set(i);
        continue;
      }
      // for AnalyzeBranch
      MachineBasicBlock *TBB = NULL, *FBB = NULL;
      SmallVector<MachineOperand, 4> Cond;
      if (!TII->AnalyzeBranch(*const_cast<MachineBasicBlock*>(MBBSrc),
                              TBB, FBB, Cond)) {
        // According to AnalyzeBranch spec, at a conditional branch,
        // Cond will hold the branch conditions
        // Further, there are two cases for conditional branches:
        // 1. conditional+fallthrough:   TBB holds branch target
        // 2. conditional+unconditional: TBB holds target of conditional branch,
        //                               FBB the target of the unconditional one
        // Hence, the branch condition will always refer to the TBB edge.
        assert( !Cond.empty() && "AnalyzeBranch for SP-IfConversion failed; "
                                 "could not determine branch condition");
        MBB_BV_map_t &PredDefs = (MBBDst == TBB) ? PredDefsT : PredDefsF;
        // if the entry of MBB does not exist yet, create it
        if (!PredDefs.count(MBBSrc)) {
          PredDefs[MBBSrc] = BitVector(PredCount);
        }
        PredDefs[MBBSrc].set(i);
      } else {
        assert(0 && "AnalyzeBranch failed");
      }
    } // end for each definition edge
  }

}


///////////////////////////////////////////////////////////////////////////////
// SPNode methods
///////////////////////////////////////////////////////////////////////////////


SPNode::SPNode(SPNode *parent, MachineBasicBlock *header,
               MachineBasicBlock *succ, unsigned int numbe)
               : Parent(parent), SuccMBB(succ), NumBackedges(numbe),
                 LoopBound(-1) {
  Level = 0;
  if (Parent) {
    // add to parent's child list
    Parent->HeaderMap[header] = this;
    Parent->Children.push_back(this);
    // add to parent's block list as well
    Parent->addMBB(header);
    Level = Parent->Level + 1;
  }
  // add header also to this SPNode's block list
  Blocks.push_back(header);
}

/// destructor - free the child nodes first, cleanup
SPNode::~SPNode() {
  for (unsigned i=0; i<Children.size(); i++) {
    delete Children[i];
  }
  Children.clear();
  HeaderMap.clear();
}

void SPNode::addMBB(MachineBasicBlock *MBB) {
  if (Blocks.front() != MBB) {
    Blocks.push_back(MBB);
  }
}


void SPNode::walk(SPNodeWalker &walker) {
  std::vector<MachineBasicBlock *> S;
  std::vector<MachineBasicBlock *> succs;
  std::map<MachineBasicBlock *, int> deps;
  // for each block in SPNode excluding header,
  // store the number of preds
  for (unsigned i=1; i<Blocks.size(); i++) {
    MachineBasicBlock *MBB = Blocks[i];
    deps[MBB] = MBB->pred_size();
    if (HeaderMap.count(MBB)) {
      SPNode *subloop = HeaderMap[MBB];
      deps[MBB] -= subloop->NumBackedges;
    }
  }

  walker.enterSubnode(this);

  S.push_back(Blocks.front());
  while(!S.empty()) {
    MachineBasicBlock *n = S.back();
    S.pop_back();
    // n is either a subloop header or a simple block of this SPNode
    if (HeaderMap.count(n)) {
      // subloop header
      SPNode *subnode = HeaderMap[n];
      subnode->walk(walker);
      succs.push_back(subnode->getSuccMBB());
    } else {
      // simple block
      succs.insert( succs.end(), n->succ_begin(), n->succ_end() );
      walker.nextMBB(n);
    }

    for (unsigned i=0; i<succs.size(); i++) {
      MachineBasicBlock *succ = succs[i];
      // successors for which all preds were visited become available
      if (succ != getHeader()) {
        deps[succ]--;
        if (deps[succ] == 0)
          S.push_back(succ);
      }
    }
    succs.clear();
  }

  walker.exitSubnode(this);
}

static void indent(unsigned level) {
  for(unsigned i=0; i<level; i++)
    dbgs() << "  ";
}

void SPNode::dump() const {
  indent(Level);
  dbgs() <<  "[BB#" << Blocks.front()->getNumber() << "]";
  if (SuccMBB) {
    dbgs() << " -> BB#" << SuccMBB->getNumber();
  }
  dbgs() << "\n";

  for (unsigned i=1; i<Blocks.size(); i++) {
    MachineBasicBlock *MBB = Blocks[i];
    if (HeaderMap.count(MBB)) {
      HeaderMap.at(MBB)->dump();
    } else {
      indent(Level+1);
      dbgs() <<  " BB#" << MBB->getNumber() << "\n";
    }
  }
}





// build the SPNode tree in DFS order, creating new SPNodes preorder
static
void createSPNodeSubtree(MachineLoop *loop, SPNode *parent,
                         std::map<const MachineLoop *, SPNode *> &M) {
  // We need to make some assumptions about the loops we can handle for now...
  // allow only one successor for SPNode
  assert( loop->getExitBlock() != NULL &&
          "Allow only one successor for loops!" );
  assert( loop->getExitingBlock() != NULL &&
          "Allow only exactly one exiting edge for loops!" );
  // for now, also:
  assert( loop->getHeader() == loop->getExitingBlock() &&
          "Allow only loops with Header == Exiting Block!" );

  SPNode *N = new SPNode(parent,
                         loop->getHeader(),
                         loop->getExitBlock(),
                         loop->getNumBackEdges()
                         );

  // update map: Loop -> SPNode
  M[loop] = N;

  for (MachineLoop::iterator I = loop->begin(), E = loop->end();
          I != E; ++I) {
    createSPNodeSubtree(*I, N, M);
  }
}



SPNode *
PatmosSinglePathInfo::createSPNodeTree(MachineFunction &MF) const {
  // Get loop information
  MachineLoopInfo &LI = getAnalysis<MachineLoopInfo>();

  // First, create a SPNode tree
  std::map<const MachineLoop *, SPNode *> M;

  SPNode *Root = new SPNode(NULL, &MF.front(), NULL, 0);

  M[NULL] = Root;

  // iterate over top-level loops
  for (MachineLoopInfo::iterator I=LI.begin(), E=LI.end(); I!=E; ++I) {
    MachineLoop *Loop = *I;
    createSPNodeSubtree(Loop, Root, M);
  }

  // Then, add MBBs to the corresponding SPNodes
  for (MachineFunction::iterator FI=MF.begin(), FE=MF.end();
          FI!=FE; ++FI) {
    MachineBasicBlock *MBB = FI;
    const MachineLoop *Loop = LI[MBB]; // also accounts for NULL (no loop)
    M[Loop]->addMBB(MBB);
  }

  return Root;
}


