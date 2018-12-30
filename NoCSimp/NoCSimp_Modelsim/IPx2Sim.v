// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on
module IPx2Sim
   #(  parameter DATA_WIDTH = 37,
       parameter FREQ = 4 
   
   /* parameter position = 4'b0101, 
      parameter LOG2_DEPTH = 5 */)
();

reg clk;
reg reset;

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

/*wire [DATA_WIDTH-1:0] Data;
wire R, W;
IP_producer #(DATA_WIDTH, 4'b0101,2) Prod(.DataOutIP(Data), .Outr(R), .Outw(W), .clk(clk),.reset(reset));
IP_consumer #(DATA_WIDTH, 4'b0000) Cons(.DataInIP(Data), .Inr(R), .Inw(W), .clk(clk),.reset(reset));
*/

wire [DATA_WIDTH-1:0] Data1, Data2;
wire Line1,Line2,Line3,Line4;
IP #(DATA_WIDTH, 4'b1111, FREQ) IP1 (.DataOutIP(Data1), .Outr(Line1),.Outw(Line2),.DataInIP(Data2),
                                     .Inr(Line3),.Inw(Line4),.clk(clk),.reset(reset));
IP #(DATA_WIDTH, 4'b0000, FREQ) IP2 (.DataOutIP(Data2), .Outr(Line3),.Outw(Line4),.DataInIP(Data1),
                                     .Inr(Line1),.Inw(Line2),.clk(clk),.reset(reset));

endmodule