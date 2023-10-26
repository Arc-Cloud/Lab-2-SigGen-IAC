module sigdelay #(
  parameter A_WIDTH = 9,
            D_WIDTH = 8
)(
  input  logic                clk,            // clock 
  input  logic                rst,            // reset
  input  logic                en,             // enable
  input  logic                wr,             // write enable
  input  logic                rd,             // read enable
  input  logic [D_WIDTH-1:0]  offset,         // increment control
  input  logic [D_WIDTH-1:0]  mic_signal,     // count 
  output logic [D_WIDTH-1:0]  delayed_signal  // count output
);

logic  [A_WIDTH-1:0]       adress1;    // interconnect wire
logic  [A_WIDTH-1:0]       adress2;    // interconnect wire


counter addrCounter (
  .clk (clk),
  .rst (rst),
  .en (en),
  .incr (offset),
  .count1 (adress1),
  .count2 (adress2)
);

ram2ports Ram(
    .clk (clk),
    .wr_en (wr_en),
    .rd_en (rd_en),
    .wr_addr (adress1),
    .rd_addr (adress2),
    .din (mic_signal),
    .dout (delayed_signal)
);
endmodule
