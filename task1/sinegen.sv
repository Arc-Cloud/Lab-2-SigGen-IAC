module sinegen#(
 parameter A_WIDTH = 8,
           D_WIDTH = 8
)(
  // interface signals
  input  logic               clk,      // clock 
  input  logic               rst,      // reset 
  input  logic               en,       // enable
  input  logic [D_WIDTH-1:0] incr,     // counter input
  output logic [D_WIDTH-1:0] dout      // rom output     
);

logic  [A_WIDTH-1:0]       adress;    // interconnect wire


counter addrCounter (
  .clk (clk),
  .rst (rst),
  .en (en),
  .incr (incr),
  .count (adress)
);

rom myRom(
    .clk (clk),
    .addr (adress),
    .dout (dout)
);
endmodule
