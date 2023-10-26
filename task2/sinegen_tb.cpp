#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "vbuddy.cpp"
#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256
#include <chrono>  
#include <thread>  

int main(int argc, char **argv, char**env){
    int simcyc;
    int clk;
    
Verilated::commandArgs(argc, argv);
// init top verilog instance
Vsinegen* top = new Vsinegen;
// init trace dump
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("sinegen.vcd");

// init Vbuddy
if (vbdOpen()!=1) return(-1);
vbdHeader("L2T1: sinegen");
//vbdSetMode(1);

// initialise simulation inputs
top->clk = 1;
top->rst = 0;
top->en = 1;
top->incr = 1;
// run simulation for many clock cycles
for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) { 


    // dump varibles into VCD file and toggle clock inputs
    for (clk=0; clk<2; clk++){
        tfp->dump (2*simcyc+clk);  // unit is in ps!
        top->clk = !top->clk;
        top->eval ();
    }

    top->incr = vbdValue();

    vbdPlot(top->dout1, 0, 255);
    vbdPlot(top->dout2, 0, 255);

    vbdCycle(simcyc);

    // change input stimuli
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
        exit(0);

    //std::this_thread::sleep_for(std::chrono::milliseconds(100); 
}

vbdClose();  // ++++
tfp->close();
exit(0);
}