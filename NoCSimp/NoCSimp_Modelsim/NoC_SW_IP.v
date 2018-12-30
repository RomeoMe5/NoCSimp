/*K SW podklu4eni 5 IP(produced/receiver). Adresacija otnositelno 16 uzlov. */
// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on
module NoC
   #(  parameter DATA_WIDTH = 37,
       parameter FREQ = 4 
   
   /* parameter position = 4'b0101, 
      parameter LOG2_DEPTH = 5 */
    )
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

wire [DATA_WIDTH-1 : 0] dataInE, dataInW, dataInS, dataInN; // 4 addres, 1 endbit
wire [DATA_WIDTH-1 : 0] dataOutE, dataOutW, dataOutS, dataOutN;
wire  Inr_N, Inr_E, Inr_S, Inr_W;
wire  Inw_N, Inw_E, Inw_S, Inw_W;
wire  Outr_N, Outr_E, Outr_S, Outr_W;
wire  Outw_N, Outw_E, Outw_S, Outw_W;



IP #(DATA_WIDTH, 4'b0001, FREQ) IPN (.DataOutIP(dataInN),.Outr(Inr_N),.Outw(Inw_N),.DataInIP(dataOutN),
                                     .Inr(Outr_N),.Inw(Outw_N),.clk(clk),.reset(reset));

IP #(DATA_WIDTH, 4'b0110, FREQ) IPE (.DataOutIP(dataInE),.Outr(Inr_E),.Outw(Inw_E),.DataInIP(dataOutE),
                                     .Inr(Outr_E),.Inw(Outw_E),.clk(clk),.reset(reset));
IP #(DATA_WIDTH, 4'b1001, FREQ) IPS (.DataOutIP(dataInS),.Outr(Inr_S),.Outw(Inw_S),.DataInIP(dataOutS),
                                     .Inr(Outr_S),.Inw(Outw_S),.clk(clk),.reset(reset));
IP #(DATA_WIDTH, 4'b0100, FREQ) IPW (.DataOutIP(dataInW),.Outr(Inr_W),.Outw(Inw_W),.DataInIP(dataOutW),
                                     .Inr(Outr_W),.Inw(Outw_W),.clk(clk),.reset(reset));
SW_IP #(DATA_WIDTH, 4'b0101, 5, FREQ) SWIP (.dataInE(dataInE),.dataInW(dataInW),.dataInS(dataInS),.dataInN(dataInN),
                                     .dataOutE(dataOutE),.dataOutW(dataOutW),.dataOutS(dataOutS),.dataOutN(dataOutN),
                                     .Inr_N(Inr_N),.Inr_E(Inr_E),.Inr_S(Inr_S),.Inr_W(Inr_W),
                                     .Inw_N(Inw_N),.Inw_E(Inw_E),.Inw_S(Inw_S),.Inw_W(Inw_W),
                                     .Outr_N(Outr_N),.Outr_E(Outr_E),.Outr_S(Outr_S),.Outr_W(Outr_W),
                                     .Outw_N(Outw_N),.Outw_E(Outw_E),.Outw_S(Outw_S),.Outw_W(Outw_W),
                                     .clk(clk),.reset(reset));                                                                    
                                                                                                      

endmodule