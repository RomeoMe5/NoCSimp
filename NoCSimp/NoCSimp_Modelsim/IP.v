module IP
   #(  parameter DATA_WIDTH = 37,
   parameter POSITION = 4'b0101,
   parameter FREQ = 4 
   /*   parameter LOG2_DEPTH = 5 */)
(
DataOutIP,
Outr,
Outw,
DataInIP,
Inr,
Inw,
clk,
reset
);
output [DATA_WIDTH-1 : 0] DataOutIP;
output Outr;
input Outw;
input [DATA_WIDTH-1 : 0] DataInIP;
output Inw;
input Inr;
input clk;
input reset;

wire Inr, Inw, Outw, Outr;

always @(posedge reset)
$display("IP block position %b resetted", POSITION);

IP_producer #(DATA_WIDTH, POSITION, FREQ) Prod(.DataOutIP(DataOutIP), .Outr(Outr), .Outw(Outw), .clk(clk),.reset(reset));
IP_consumer #(DATA_WIDTH, POSITION) Cons(.DataInIP(DataInIP), .Inr(Inr), .Inw(Inw), .clk(clk),.reset(reset));



endmodule

