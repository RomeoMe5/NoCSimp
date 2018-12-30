// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on
module ProdConSim
   #(  parameter DATA_WIDTH = 37
   /* parameter position = 4'b0101, 
      parameter LOG2_DEPTH = 5 */)
();

reg clk;
reg reset;
wire [DATA_WIDTH-1:0] Data;
wire R, W;
initial 
begin 
  $display("Start simulation at %t",$time); 
  clk=0;
  reset=0;
  #(10) reset =1'b1;
  #(10) reset =1'b0;
end
always
begin
  #1 clk=~clk;
end

IP_producer #(DATA_WIDTH, 4'b0101,2) Prod(.DataOutIP(Data), .Outr(R), .Outw(W), .clk(clk),.reset(reset));
IP_consumer #(DATA_WIDTH, 4'b0000) Cons(.DataInIP(Data), .Inr(R), .Inw(W), .clk(clk),.reset(reset));



endmodule