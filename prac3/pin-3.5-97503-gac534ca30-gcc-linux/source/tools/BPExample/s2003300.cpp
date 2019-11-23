#include <iostream>
#include <fstream>
#include <cstdlib>
#include "pin.H"

// Simulation will be stop once this number of instructions is executed
#define STOP_INSTR_NUM 1000000000 //1b instrs
// Simulator heartbeat rate
#define SIMULATOR_HEARTBEAT_INSTR_NUM 100000000 //100m instrs

/* Base branch predictor class */
// Your are highly recommended to follow this design
// when implementing yours branch predictors
class BranchPredictorInterface {
public:
  //This function returns a prediction for a branch instruction with address branchIP
  virtual bool getPrediction(ADDRINT branchIP) = 0;
  //This function updates branch predictor's history with outcome of branch instruction with address branchIP
  virtual void train(ADDRINT branchIP, bool correctBranchDirection) = 0;
};

// This is a class which implements always taken branch predictor
class AlwaysTakenBranchPredictor : public BranchPredictorInterface {
public:
  AlwaysTakenBranchPredictor(UINT64 numberOfEntries) {}; //no entries here: always taken branch predictor is the simplest predictor
	virtual bool getPrediction(ADDRINT branchIP) {
		return true; // predict taken
	}
	virtual void train(ADDRINT branchIP, bool correctBranchDirection) {} //nothing to do here: always taken branch predictor does not have history
};

//##############################################

// saturating 2-bit counter
static int hysteresis (int predict, bool correct)
{
  int train = 3;

  if (correct)
  {
    switch (predict) 
    {
      case 0: 
      {  
        train = 1;
        break;
      }
      case 1: 
      {  
        train = 2;
        break;
      }
      case 2: 
      {  
        train = 3;
        break;
      }
      case 3: 
      {  
        train = 3;
        break;
      }
      default: break; // default PHT entrie value is “11” (i.e. 3)
    }
  } else // !correct
  {
    switch (predict) 
    {
      case 0: 
      {  
        train = 0;
        break;
      }
      case 1: 
      {  
        train = 0;
        break;
      }
      case 2: 
      {  
        train = 1;
        break;
      }
      case 3: 
      {  
        train = 2;
        break;
      }
      default: break; // default PHT entrie value is “11” (i.e. 3)
    }

  return train;
}

// Class for Local Branch predictor
class LocalBranchPredictor : public BranchPredictorInterface 
{
private:
  int LHRSize = 12; 
  int LHR[128];
  int PHT[4096]; // maximum possible size, default

public:
  
  LocalBranchPredictor(UINT64 numberOfEntries) 
  { 
    std::fill(&LHR, &LHR + sizeof(LHR) , 0); // Initialize all LHRs to 0
    switch(numberOfEntries) 
    {
      case 128: 
      {  
        LHRSize = 7;
        break;
      }
      case 1024: 
      {  
        LHRSize = 10;
        break;
      }
      case 4096: 
      {  
        //LHRSize = 12; // maximum possible size, default
        break;
      }
      default: break; // keep default size of 12
    }
    std::fill(PHT, PHT + sizeof(PHT), 3); // Initialize all PHT entries to “11” (i.e. 3)
  };
  
  virtual bool getPrediction(ADDRINT branchIP) // branchIP is a 64-bit value
  {    
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    int pre = PHT[PHTindex];
    bool predict = true;
    if (pre == 2 || pre == 3)
    {
      predict = true;
    } else if (pre == 0 || pre == 1)
    {
      predict = false;
    }
    return predict;
	}

	virtual void train(ADDRINT branchIP, bool correctBranchDirection) 
  {
    // strengthen or weaken an used PHT entry
    bool predict = getPrediction(branchIP);
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    PHT[PHTindex] = hysteresis (predict, correctBranchDirection);
    
    // Update LHR
    LHR[LSBs] = (LHR[LSBs] << 1);
    LHR[LSBs] = (LHR[LSBs] | predict);
  }

};

// Class for Gshare Branch predictor
class GshareBranchPredictor : public BranchPredictorInterface 
{
// private members for Gshare Branch predictor
private:
  int LHRSize = 12; 
  int LHR[128];
  int PHT[4096]; // maximum possible size, default

public:
  
  LocalBranchPredictor(UINT64 numberOfEntries) 
  { 
    std::fill(&LHR, &LHR + sizeof(LHR) , 0); // Initialize all LHRs to 0
    switch(numberOfEntries) 
    {
      case 128: 
      {  
        LHRSize = 7;
        break;
      }
      case 1024: 
      {  
        LHRSize = 10;
        break;
      }
      case 4096: 
      {  
        //LHRSize = 12; // maximum possible size, default
        break;
      }
      default: break; // keep default size of 12
    }
    std::fill(PHT, PHT + sizeof(PHT), 3); // Initialize all PHT entries to “11” (i.e. 3)
  };
  
  virtual bool getPrediction(ADDRINT branchIP) // branchIP is a 64-bit value
  {    
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    int pre = PHT[PHTindex];
    bool predict = true;
    if (pre == 2 || pre == 3)
    {
      predict = true;
    } else if (pre == 0 || pre == 1)
    {
      predict = false;
    }
    return predict;
	}

	virtual void train(ADDRINT branchIP, bool correctBranchDirection) 
  {
    // strengthen or weaken an used PHT entry
    bool predict = getPrediction(branchIP);
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    PHT[PHTindex] = hysteresis (predict, correctBranchDirection);
    
    // Update LHR
    LHR[LSBs] = (LHR[LSBs] << 1);
    LHR[LSBs] = (LHR[LSBs] | predict);
  }
};

// Class for Tournament Branch predictor
class TournamentBranchPredictor : public BranchPredictorInterface 
{
// private members for Tournament Branch predictor
private:
  int LHRSize = 12; 
  int LHR[128];
  int PHT[4096]; // maximum possible size, default

public:
  
  LocalBranchPredictor(UINT64 numberOfEntries) 
  { 
    std::fill(&LHR, &LHR + sizeof(LHR) , 0); // Initialize all LHRs to 0
    switch(numberOfEntries) 
    {
      case 128: 
      {  
        LHRSize = 7;
        break;
      }
      case 1024: 
      {  
        LHRSize = 10;
        break;
      }
      case 4096: 
      {  
        //LHRSize = 12; // maximum possible size, default
        break;
      }
      default: break; // keep default size of 12
    }
    std::fill(PHT, PHT + sizeof(PHT), 3); // Initialize all PHT entries to “11” (i.e. 3)
  };
  
  virtual bool getPrediction(ADDRINT branchIP) // branchIP is a 64-bit value
  {    
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    int pre = PHT[PHTindex];
    bool predict = true;
    if (pre == 2 || pre == 3)
    {
      predict = true;
    } else if (pre == 0 || pre == 1)
    {
      predict = false;
    }
    return predict;
	}

	virtual void train(ADDRINT branchIP, bool correctBranchDirection) 
  {
    // strengthen or weaken an used PHT entry
    bool predict = getPrediction(branchIP);
    int LSBs = (branchIP & 0b1111111);
    if (LSBs > 127)
    {
      LSBs = 127;
    }
    int PHTindex = LHR[LSBs];
    PHT[PHTindex] = hysteresis (predict, correctBranchDirection);
    
    // Update LHR
    LHR[LSBs] = (LHR[LSBs] << 1);
    LHR[LSBs] = (LHR[LSBs] | predict);
  }
};

//##############################################

ofstream OutFile;
BranchPredictorInterface *branchPredictor;

KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool",
    "o", "BP_stats.out", "specify output file name");
KNOB<UINT64> KnobNumberOfEntriesInBranchPredictor(KNOB_MODE_WRITEONCE, "pintool",
    "num_BP_entries", "1024", "specify number of entries in a branch predictor");
KNOB<string> KnobBranchPredictorType(KNOB_MODE_WRITEONCE, "pintool",
    "BP_type", "always_taken", "specify type of branch predictor to be used");

// The running counts of branches, predictions and instructions are kept here
static UINT64 iCount                          = 0;
static UINT64 correctPredictionCount          = 0;
static UINT64 conditionalBranchesCount        = 0;
static UINT64 takenBranchesCount              = 0;
static UINT64 notTakenBranchesCount           = 0;
static UINT64 predictedTakenBranchesCount     = 0;
static UINT64 predictedNotTakenBranchesCount  = 0;

VOID docount() {
  // Update instruction counter
  iCount++;
  // Print this message every SIMULATOR_HEARTBEAT_INSTR_NUM executed
  if (iCount % SIMULATOR_HEARTBEAT_INSTR_NUM == 0) {
    std::cerr << "Executed " << iCount << " instructions." << endl;
  }
  // Release control of application if STOP_INSTR_NUM instructions have been executed
  if (iCount == STOP_INSTR_NUM) {
    PIN_Detach();
  }
}

VOID TerminateSimulationHandler(VOID *v) {
  OutFile.setf(ios::showbase);
  // At the end of a simulation, print counters to a file
  OutFile << "Prediction accuracy:\t"            << (double)correctPredictionCount / (double)conditionalBranchesCount << endl
          << "Number of conditional branches:\t" << conditionalBranchesCount                                      << endl
          << "Number of correct predictions:\t"  << correctPredictionCount                                        << endl
          << "Number of taken branches:\t"       << takenBranchesCount                                            << endl
          << "Number of non-taken branches:\t"   << notTakenBranchesCount                                         << endl
          ;
  OutFile.close();

  std::cerr << endl << "PIN has been detached at iCount = " << STOP_INSTR_NUM << endl;
  std::cerr << endl << "Simulation has reached its target point. Terminate simulation." << endl;
  std::cerr << "Prediction accuracy:\t" << (double)correctPredictionCount / (double)conditionalBranchesCount << endl;
  std::exit(EXIT_SUCCESS);
}

//
VOID Fini(int code, VOID * v)
{
  TerminateSimulationHandler(v);
}

// This function is called before every conditional branch is executed
static VOID AtConditionalBranch(ADDRINT branchIP, BOOL correctBranchDirection) {
  /*
	 * This is the place where predictor is queried for a prediction and trained
	 */

	bool prediction = branchPredictor->getPrediction(branchIP);
	branchPredictor->train(branchIP, correctBranchDirection);

  // Update stat counters
  if (prediction) {
    predictedTakenBranchesCount++;
  } else {
    predictedNotTakenBranchesCount++;
  }
  if (correctBranchDirection) {
    takenBranchesCount++;
  } else {
    notTakenBranchesCount++;
  }
	if (prediction == correctBranchDirection) correctPredictionCount++;
  conditionalBranchesCount++;
}

// Pin calls this function every time a new instruction is encountered
VOID Instruction(INS ins, VOID *v) {
  //Inser a call before every instruction to count them
  INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)docount, IARG_END);

  // Insert a call before every conditional branch
  if ( INS_IsBranch(ins) && INS_HasFallThrough(ins) ) {
    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)AtConditionalBranch, IARG_INST_PTR, IARG_BRANCH_TAKEN, IARG_END);
  }
}

// Print Help Message
INT32 Usage() {
  cerr << "This tool simulates different types of branch predictors" << endl;
  cerr << endl << KNOB_BASE::StringKnobSummary() << endl;
  return -1;
}

int main(int argc, char * argv[]) {
  // Initialize pin
  if (PIN_Init(argc, argv)) return Usage();

  // Create a branch predictor object of requested type
  if (KnobBranchPredictorType.Value() == "always_taken") {
    std::cerr << "Using always taken BP" << std::endl;
    branchPredictor = new AlwaysTakenBranchPredictor(KnobNumberOfEntriesInBranchPredictor.Value());
  }
//---------------------------------------------------------------------
//##############################################
/*
 * Your changes here.
 *
 * Create an object of branch predictor class you implemented in the following sections.
 *
 * NOTE:
 *  KnobNumberOfEntriesInBranchPredictor.Value() returns the value specified after tool option "-num_BP_entries"
 *    Argument of tool option "-num_BP_entries" is an integer
 *  KnobBranchPredictorType.Value() returns the value specified after tool option "-BP_type"
 *    Argument of tool option "-BP_type" can be one of the followong strings: "always_taken", "local", "gshare", "tournament"
 *    Please DO NOT CHANGE these strings as they will be used for testing your code
 */
//---------------------------------------------------------------------
//##############################################
  else if (KnobBranchPredictorType.Value() == "local") {
  	 std::cerr << "Using Local BP." << std::endl;
/* Uncomment when you implemented Local branch predictor */
    branchPredictor = new LocalBranchPredictor(KnobNumberOfEntriesInBranchPredictor.Value());
  }
  else if (KnobBranchPredictorType.Value() == "gshare") {
  	 std::cerr << "Using Gshare BP."<< std::endl;
/* Uncomment when you implemented Gshare branch predictor */
    branchPredictor = new GshareBranchPredictor(KnobNumberOfEntriesInBranchPredictor.Value());
  }
  else if (KnobBranchPredictorType.Value() == "tournament") {
  	 std::cerr << "Using Tournament BP." << std::endl;
/* Uncomment when you implemented tournament branch predictor */
    branchPredictor = new TournamentBranchPredictor(KnobNumberOfEntriesInBranchPredictor.Value());
  }
  else {
    std::cerr << "Error: No such type of branch predictor. Simulation will be terminated." << std::endl;
    std::exit(EXIT_FAILURE);
  }

  std::cerr << "The simulation will run " << STOP_INSTR_NUM << " instructions." << std::endl;

  OutFile.open(KnobOutputFile.Value().c_str());

  // Register Instruction to be called to instrument instructions
  INS_AddInstrumentFunction(Instruction, 0);

  // Function to be called if the porgram finishes before it completes 10b instructions
  PIN_AddFiniFunction(Fini, 0);

  // Callback functions to invoke before Pin releases control of the application
  PIN_AddDetachFunction(TerminateSimulationHandler, 0);

  // Start the program, never returns
  PIN_StartProgram();

  return 0;
}
