module sinegen#(
 parameter A_WIDTH = 8,
           D_WIDTH = 8
)(
  // interface signals
  input  logic               clk,      // clock 
  input  logic               rst,      // reset 
  input  logic               en,       // enable
  input  logic [D_WIDTH-1:0] incr,     // counter input
  output logic [D_WIDTH-1:0] dout1,      // rom output     
  output logic [D_WIDTH-1:0] dout2,      // rom output     
);

logic  [A_WIDTH-1:0]       adress1;    // interconnect wire
logic  [A_WIDTH-1:0]       adress2;    // interconnect wire



counter addrCounter (
  .clk (clk),
  .rst (rst),
  .en (en),
  .incr (incr),
  .count1 (adress1),
  .count2 (adress2)
);

rom2ports myRom(
    .clk (clk),
    .addr1 (adress1),
    .addr2 (adress2),
    .dout1 (dout1),
    .dout2 (dout2)
);
endmodule
