/*K SW podklu4eni 5 IP(produced/receiver). Adresacija otnositelno 16 uzlov. */
// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on
module SW_IP_test
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


wire [DATA_WIDTH-1 : 0] dataInE, dataInW, dataInS, dataInN; // 4 addres, 1 endbit
wire [DATA_WIDTH-1 : 0] dataOutE, dataOutW, dataOutS, dataOutN;
wire  Inr_N, Inr_E, Inr_S, Inr_W;
wire  Inw_N, Inw_E, Inw_S, Inw_W;
wire  Outr_N, Outr_E, Outr_S, Outr_W;
wire  Outw_N, Outw_E, Outw_S, Outw_W;

assign Inr_N=1'b0;
assign Inr_E=1'b0;
assign Inr_W=1'b0;
assign Inr_S=1'b0;
assign Inw_N=1'b0;
assign Inw_E=1'b0;
assign Inw_W=1'b0;
assign Inw_S=1'b0;
assign Outr_N=1'b0;
assign Outr_E=1'b0;
assign Outr_W=1'b0;
assign Outr_S=1'b0;
assign Outw_N=1'b0;
assign Outw_E=1'b0;
assign Outw_W=1'b0;
assign Outw_S=1'b0;

/*SW_IP #(DATA_WIDTH, 4'b0001, 5, FREQ) SW0001 (.dataOutS(dataInN),.Outr_S(Inr_N),.Outw_S(Inw_N),.dataInS(dataOutN),
                                     .Inr_S(Outr_N),.Inw_S(Outw_N),.clk(clk),.reset(reset));

SW_IP #(DATA_WIDTH, 4'b0110, 5, FREQ) SW0110 (.dataOutW(dataInE),.Outr_W(Inr_E),.Outw_W(Inw_E),.dataInW(dataOutE),
                                     .Inr_W(Outr_E),.Inw_W(Outw_E),.clk(clk),.reset(reset));
SW_IP #(DATA_WIDTH, 4'b1001, 5, FREQ) SW1001 (.dataOutN(dataInS),.Outr_N(Inr_S),.Outw_N(Inw_S),.dataInN(dataOutS),
                                     .Inr_N(Outr_S),.Inw_N(Outw_S),.clk(clk),.reset(reset));
SW_IP #(DATA_WIDTH, 4'b0100, 5, FREQ) SW0100 (.dataOutE(dataInW),.Outr_E(Inr_W),.Outw_E(Inw_W),.dataInE(dataOutW),
                                     .Inr_E(Outr_W),.Inw_E(Outw_W),.clk(clk),.reset(reset));
*/SW_IP #(DATA_WIDTH, 4'b0101, 1, FREQ) SW0101 (.dataInE(dataInE),.dataInW(dataInW),.dataInS(dataInS),.dataInN(dataInN),
                                     .dataOutE(dataOutE),.dataOutW(dataOutW),.dataOutS(dataOutS),.dataOutN(dataOutN),
                                     .Inr_N(Inr_N),.Inr_E(Inr_E),.Inr_S(Inr_S),.Inr_W(Inr_W),
                                     .Inw_N(Inw_N),.Inw_E(Inw_E),.Inw_S(Inw_S),.Inw_W(Inw_W),
                                     .Outr_N(Outr_N),.Outr_E(Outr_E),.Outr_S(Outr_S),.Outr_W(Outr_W),
                                     .Outw_N(Outw_N),.Outw_E(Outw_E),.Outw_S(Outw_S),.Outw_W(Outw_W),
                                     .clk(clk),.reset(reset));                     
//wire [DATA_WIDTH-1 : 0] data1, data2, data3, data4, data5, data6, data7, data8; // 4 addres, 1 endbit
//wire  Inr_1, Inr_2, Inr_3, Inr_4, Inr_5, Inr_6, Inr_7, Inr_8;
//wire  Inw_1, Inw_2, Inw_3, Inw_4, Inw_5, Inw_6, Inw_7, Inw_8;
//wire [DATA_WIDTH-1 : 0] null
//wire  Outr_1, Outr_2, Outr_3, Outr_4, Outr_5, Outr_6, Outr_7, Outr_8;
//wire  Outw_1, Outw_2, Outw_3, Outw_4, Outw_5, Outw_6, Outw_7, Outw_8;
//reg null = '0;
//reg [DATA_WIDTH-1 : 0] 



/*SW_IP #(DATA_WIDTH, 4'b0000, 5, FREQ) SWIP0000 (.dataInE(data1),
                                     .dataOutE(data3),
                                     .Inr_E(Inr_1),
                                     .Inw_E(Inw_1),
                                     .Outr_E(Inr_3),
                                     .Outw_E(Inw_3),
                                     .clk(clk),.reset(reset));  
SW_IP #(DATA_WIDTH, 4'b0001, 5, FREQ) SWIP0001 (.dataInW(data3),
                                     .dataOutW(data1),
                                     .Inr_W(Inw_1),
                                     .Inw_W(Inr_1),
                                     .Outr_W(Inw_3),
                                     .Outw_W(Inr_3),
                                     .clk(clk),.reset(reset));  
*/
/*SW_IP #(DATA_WIDTH, 4'b0000, 5, FREQ) SWIP0000 (.dataInE(data1),.dataInS(data2),
                                     .dataOutE(data3),.dataOutS(data4),
                                     .Inr_E(Inr_1),.Inr_S(Inr_2),
                                     .Inw_E(Inw_1),.Inw_S(Inw_2),
                                     .Outr_E(Inr_3),.Outr_S(Inr_4),
                                     .Outw_E(Inw_3),.Outw_S(Inw_4),
                                     .clk(clk),.reset(reset));  
SW_IP #(DATA_WIDTH, 4'b0001, 5, FREQ) SWIP0001 (.dataInW(data3),.dataInS(data5),
                                     .dataOutW(data1),.dataOutS(data6),
                                     .Inr_S(Inw_3),.Inr_W(Inr_5),
                                     .Inw_S(Inr_3),.Inw_W(Inw_5),
                                     .Outr_S(Inw_1),.Outr_W(Inr_6),
                                     .Outw_S(Inr_1),.Outw_W(Inw_6),
                                     .clk(clk),.reset(reset));  
SW_IP #(DATA_WIDTH, 4'b0101, 5, FREQ) SWIP0101 (.dataInW(data7),.dataInN(data6),
                                     .dataOutW(data8),.dataOutN(data5),
                                     .Inr_N(Inr_7),.Inr_W(Inw_6),
                                     .Inw_N(Inw_7),.Inw_W(Inr_6),
                                     .Outr_N(Inr_8),.Outr_W(Inw_5),
                                     .Outw_N(Inw_8),.Outw_W(Inr_5),
                                     .clk(clk),.reset(reset));  
SW_IP #(DATA_WIDTH, 4'b0100, 5, FREQ) SWIP0100 (.dataInE(data8),.dataInN(data4),
                                     .dataOutE(data7),.dataOutN(data2),
                                     .Inr_N(Inw_8),.Inr_E(Inw_4),
                                     .Inw_N(Inr_8),.Inw_E(Inr_4),
                                     .Outr_N(Inw_7),.Outr_E(Inw_2),
                                     .Outw_N(Inr_7),.Outw_E(Inr_2),
                                     .clk(clk),.reset(reset));                                                                                                                 
*/                                                                
                                                                                                      

endmodule