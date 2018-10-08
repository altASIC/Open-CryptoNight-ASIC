#include "Vcn_top_tb.h"
// #include "Vcn_top.h"
#include "verilated.h"
int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    printf("Starting sim\n");
    long clocks = 0;
    Vcn_top_tb* top = new Vcn_top_tb;
    // Vcn_top* top = new Vcn_top;
    top->clk = 0;
    while (!Verilated::gotFinish()) {
      top->clk = !top->clk;
      top->eval();
      clocks++;
      // if (!(clocks%100000))
      //   printf("eval: %ld\n", clocks);
    }
    delete top;
    exit(0);
}
