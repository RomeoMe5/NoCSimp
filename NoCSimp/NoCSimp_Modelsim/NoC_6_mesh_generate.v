/*K SW podklu4eni 5 IP(produced/receiver). Adresacija otnositelno 16 uzlov. */
// synopsys translate_off
`timescale 1 ns / 1 ns
// synopsys translate_on
module NoC_8_SWIP
   #(  parameter DATA_WIDTH = 37,
       parameter FREQ = 25,
       parameter N =8 
   /* parameter position = 4'b0101, 
      parameter LOG2_DEPTH = 5 */
    )
();

reg clk;
reg reset;
integer t;

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
   t=$time;
  if (t>2001) $stop;
end


//wire [DATA_WIDTH-1 : 0] dataInE, dataInW, dataInS, dataInN; // 4 addres, 1 endbit
//wire [DATA_WIDTH-1 : 0] dataOutE, dataOutW, dataOutS, dataOutN;
//wire  Inr_N, Inr_E, Inr_S, Inr_W;
//wire  Inw_N, Inw_E, Inw_S, Inw_W;
//wire  Outr_N, Outr_E, Outr_S, Outr_W;
//wire  Outw_N, Outw_E, Outw_S, Outw_W;
//wire nul;
//assign nul = 1'b0;
genvar y,x;

wire [DATA_WIDTH-1 : 0] dataIn[12-1 : 0][3 : 0];
wire [DATA_WIDTH-1 : 0] dataOut[12-1 : 0][3 : 0];
wire  Inr [12-1 : 0][3 :0];
wire  Inw [12-1 : 0][3 :0];
wire  Outr [12-1 : 0][3 :0];
wire  Outw [12-1 : 0][3 :0];

//routes



assign dataIn[0][0] = dataOut[1][0];
assign dataIn[1][0] = dataOut[0][0];
assign Inr[0][0] = Outr[1][0];
assign Inr[1][0] = Outr[0][0];
assign Outw[0][0] = Inw[1][0];
assign Outw[1][0] = Inw[0][0];

assign dataIn[0][1] = dataOut[7][0];
assign dataIn[7][0] = dataOut[0][1];
assign Inr[0][1] = Outr[7][0];
assign Inr[7][0] = Outr[0][1];
assign Outw[0][1] = Inw[7][0];
assign Outw[7][0] = Inw[0][1];

assign dataIn[1][1] = dataOut[2][0];
assign dataIn[2][0] = dataOut[1][1];
assign Inr[1][1] = Outr[2][0];
assign Inr[2][0] = Outr[1][1];
assign Outw[1][1] = Inw[2][0];
assign Outw[2][0] = Inw[1][1];

assign dataIn[1][2] = dataOut[3][0];
assign dataIn[3][0] = dataOut[1][2];
assign Inr[1][2] = Outr[3][0];
assign Inr[3][0] = Outr[1][2];
assign Outw[1][2] = Inw[3][0];
assign Outw[3][0] = Inw[1][2];

assign dataIn[2][1] = dataOut[3][1];
assign dataIn[3][1] = dataOut[2][1];
assign Inr[2][1] = Outr[3][1];
assign Inr[3][1] = Outr[2][1];
assign Outw[2][1] = Inw[3][1];
assign Outw[3][1] = Inw[2][1];

assign dataIn[2][2] = dataOut[4][0];
assign dataIn[4][0] = dataOut[2][2];
assign Inr[2][2] = Outr[4][0];
assign Inr[4][0] = Outr[2][2];
assign Outw[2][2] = Inw[4][0];
assign Outw[4][0] = Inw[2][2];

assign dataIn[3][2] = dataOut[5][0];
assign dataIn[5][0] = dataOut[3][2];
assign Inr[3][2] = Outr[5][0];
assign Inr[5][0] = Outr[3][2];
assign Outw[3][2] = Inw[5][0];
assign Outw[5][0] = Inw[3][2];

assign dataIn[3][3] = dataOut[6][0];
assign dataIn[6][0] = dataOut[3][3];
assign Inr[3][3] = Outr[6][0];
assign Inr[6][0] = Outr[3][3];
assign Outw[3][3] = Inw[6][0];
assign Outw[6][0] = Inw[3][3];

assign dataIn[4][1] = dataOut[7][1];
assign dataIn[7][1] = dataOut[4][1];
assign Inr[4][1] = Outr[7][1];
assign Inr[7][1] = Outr[4][1];
assign Outw[4][1] = Inw[7][1];
assign Outw[7][1] = Inw[4][1];

assign dataIn[5][1] = dataOut[7][2];
assign dataIn[7][2] = dataOut[5][1];
assign Inr[5][1] = Outr[7][2];
assign Inr[7][2] = Outr[5][1];
assign Outw[5][1] = Inw[7][2];
assign Outw[7][2] = Inw[5][1];

assign dataIn[6][1] = dataOut[7][3];
assign dataIn[7][3] = dataOut[6][1];
assign Inr[6][1] = Outr[7][3];
assign Inr[7][3] = Outr[6][1];
assign Outw[6][1] = Inw[7][3];
assign Outw[7][3] = Inw[6][1];

assign dataIn[0][2] = '0;
assign Inr[0][2] = '0;
assign Outw[0][2] = '0;

assign dataIn[0][3] = '0;
assign Inr[0][3] = '0;
assign Outw[0][3] = '0;

assign dataIn[1][3] = '0;
assign Inr[1][3] = '0;
assign Outw[1][3] = '0;

assign dataIn[2][3] = '0;
assign Inr[2][3] = '0;
assign Outw[2][3] = '0;

assign dataIn[4][2] = '0;
assign Inr[4][2] = '0;
assign Outw[4][2] = '0;

assign dataIn[4][3] = '0;
assign Inr[4][3] = '0;
assign Outw[4][3] = '0;

assign dataIn[5][2] = '0;
assign Inr[5][2] = '0;
assign Outw[5][2] = '0;

assign dataIn[5][3] = '0;
assign Inr[5][3] = '0;
assign Outw[5][3] = '0;

assign dataIn[6][2] = '0;
assign Inr[6][2] = '0;
assign Outw[6][2] = '0;

assign dataIn[6][3] = '0;
assign Inr[6][3] = '0;
assign Outw[6][3] = '0;





generate
  for (y=0;y<N;y=y+1)
  begin
    /*for (x=0;x<N;x=x+1)
    begin*/
    /*
	if (y==0)
      begin 
        assign dataIn[N][3] = '0;
        assign dataOut[N][3] = '0;
        assign Inr[N][3] = '0;
        assign Inw[N][3] = '0;
        assign Outr[N][3] = '0;
        assign Outw[N][3] = '0;
      end
    else
      begin 
        assign dataIn[N][3] = dataOut[(y-1)*N+x][1];
        //assign dataOut[N][3] = dataIn[(y-1)*N+x][1];
        assign dataIn[(y-1)*N+x][1] = dataOut[N][3];
        assign Inr[N][3] = Outr[(y-1)*N+x][1];
       // assign Inw[N][3] = Inr[(y-1)*N+x][1];
          assign Inr[(y-1)*N+x][1] = Outr[N][3];
        //assign Outr[N][3] = Outw[(y-1)*N+x][1];
        assign Outw[(y-1)*N+x][1] = Inw[N][3];
        assign Outw[N][3] = Inw[(y-1)*N+x][1];
      end 
    if (y==(N-1))
      begin 
        assign dataIn[N][1] = '0;
        assign dataOut[N][1] = '0;
        assign Inr[N][1] = '0;
        assign Inw[N][1] = '0;
        assign Outr[N][1] = '0;
        assign Outw[N][1] = '0;
      end
      
    if (x==0)
      begin 
        assign dataIn[N][0] = '0;
        assign dataOut[N][0] = '0;
        assign Inr[N][0] = '0;
        assign Inw[N][0] = '0;
        assign Outr[N][0] = '0;
        assign Outw[N][0] = '0;
      end
    else
      begin 
        assign dataIn[N][0] = dataOut[(y)*N+x-1][2];
        //assign dataOut[N][0] = dataIn[(y)*N+x-1][2];
        assign dataIn[(y)*N+x-1][2] = dataOut[N][0];
        assign Inr[N][0] = Outr[(y)*N+x-1][2];
        //assign Inw[N][0] = Inr[(y)*N+x-1][2];
        assign Inr[(y)*N+x-1][2] = Outr[N][0];
        //assign Outr[N][0] = Outw[(y)*N+x-1][2];
        assign Outw[(y)*N+x-1][2] = Inw[N][0];
        assign Outw[N][0] = Inw[(y)*N+x-1][2];
      end 
    if (x==(N-1))
      begin 
        assign dataIn[N][2] = '0;
        assign dataOut[N][2] = '0;
        assign Inr[N][2] = '0;
        assign Inw[N][2] = '0;
        assign Outr[N][2] = '0;
        assign Outw[N][2] = '0;
      end  
	 */
    //end
//end  
//endgenerate    
    
//generate    
//      for (y=0;y<N;y=y+1)
//      begin
//        for (x=0;x<N;x=x+1)
//        begin
          //SW_IP  node (.clk(clk),.reset(reset));
          SW_IP #(DATA_WIDTH, y, 7, FREQ) node (.dataInW(dataIn[y][0]),.dataInS(dataIn[y][1]),.dataInE(dataIn[y][2]),.dataInN(dataIn[y][3]),
                                     .dataOutW(dataOut[y][0]),.dataOutS(dataOut[y][1]),.dataOutE(dataOut[y][2]),.dataOutN(dataOut[y][3]),
                                     .Inr_W(Inr[y][0]),.Inr_S(Inr[y][1]),.Inr_E(Inr[y][2]),.Inr_N(Inr[y][3]),
                                     .Inw_W(Inw[y][0]),.Inw_S(Inw[y][1]),.Inw_E(Inw[y][2]),.Inw_N(Inw[y][3]),
                                     .Outr_W(Outr[y][0]),.Outr_S(Outr[y][1]),.Outr_E(Outr[y][2]),.Outr_N(Outr[y][3]),
                                     .Outw_W(Outw[y][0]),.Outw_S(Outw[y][1]),.Outw_E(Outw[y][2]),.Outw_N(Outw[y][3]),
                                     .clk(clk),.reset(reset));
									
//      end
//      end
  //end
  end
endgenerate
/*switch #(DATA_WIDTH, 8, 7) nodez (.dataInW(dataIn[8][0]),.dataInS(dataIn[8][1]),.dataInE(dataIn[8][2]),.dataInN(dataIn[8][3]),
                                     .dataOutW(dataOut[8][0]),.dataOutS(dataOut[8][1]),.dataOutE(dataOut[8][2]),.dataOutN(dataOut[8][3]),
                                     .Inr_W(Inr[8][0]),.Inr_S(Inr[8][1]),.Inr_E(Inr[8][2]),.Inr_N(Inr[8][3]),
                                     .Inw_W(Inw[8][0]),.Inw_S(Inw[8][1]),.Inw_E(Inw[8][2]),.Inw_N(Inw[8][3]),
                                     .Outr_W(Outr[8][0]),.Outr_S(Outr[8][1]),.Outr_E(Outr[8][2]),.Outr_N(Outr[8][3]),
                                     .Outw_W(Outw[8][0]),.Outw_S(Outw[8][1]),.Outw_E(Outw[8][2]),.Outw_N(Outw[8][3]),
                                     .clk(clk),.reset(reset));
*/	
  
//sim of 2 sw - works good
/*SW_IP #(DATA_WIDTH, 4'b0001, 5, FREQ) SW0001 (.dataOutS(dataInN),.Outr_S(Inr_N),.Outw_S(Inw_N),.dataInS(dataOutN),
                                     .Inr_S(Outr_N),.Inw_S(Outw_N),.clk(clk),.reset(reset),
                                     .Inr_N(nul),.Inr_E(nul),.Inr_W(nul),
                                     .Inw_N(nul),.Inw_E(nul),.Inw_W(nul),
                                     .Outr_N(nul),.Outr_E(nul),.Outr_W(nul),
                                     .Outw_N(nul),.Outw_E(nul),.Outw_W(nul));
SW_IP #(DATA_WIDTH, 4'b0101, 5, FREQ) SW0101 (.dataInN(dataInN),.Inr_N(Inr_N),.Inw_N(Inw_N),.dataOutN(dataOutN),
                                     .Outr_N(Outr_N),.Outw_N(Outw_N),.clk(clk),.reset(reset),
                                     .Inr_S(nul),.Inr_E(nul),.Inr_W(nul),
                                     .Inw_S(nul),.Inw_E(nul),.Inw_W(nul),
                                     .Outr_S(nul),.Outr_E(nul),.Outr_W(nul),
                                     .Outw_S(nul),.Outw_E(nul),.Outw_W(nul));
*/
//sim of 2 sw

/*SW_IP #(DATA_WIDTH, 4'b0001, 5, FREQ) SW0001 (.dataOutS(dataInN),.Outr_S(Inr_N),.Outw_S(Inw_N),.dataInS(dataOutN),
                                     .Inr_S(Outr_N),.Inw_S(Outw_N),.clk(clk),.reset(reset),
                                     .Inr_N(nul),.Inr_E(nul),.Inr_W(nul),
                                     .Inw_N(nul),.Inw_E(nul),.Inw_W(nul),
                                     .Outr_N(nul),.Outr_E(nul),.Outr_W(nul),
                                     .Outw_N(nul),.Outw_E(nul),.Outw_W(nul));
SW_IP #(DATA_WIDTH, 4'b0110, 5, FREQ) SW0110 (.dataOutW(dataInE),.Outr_W(Inr_E),.Outw_W(Inw_E),.dataInW(dataOutE),
                                     .Inr_W(Outr_E),.Inw_W(Outw_E),.clk(clk),.reset(reset),
                                     .Inr_N(nul),.Inr_E(nul),.Inr_S(nul),
                                     .Inw_N(nul),.Inw_E(nul),.Inw_S(nul),
                                     .Outr_N(nul),.Outr_E(nul),.Outr_S(nul),
                                     .Outw_N(nul),.Outw_E(nul),.Outw_S(nul));
SW_IP #(DATA_WIDTH, 4'b1001, 5, FREQ) SW1001 (.dataOutN(dataInS),.Outr_N(Inr_S),.Outw_N(Inw_S),.dataInN(dataOutS),
                                     .Inr_N(Outr_S),.Inw_N(Outw_S),.clk(clk),.reset(reset),
                                     .Inr_E(nul),.Inr_S(nul),.Inr_W(nul),
                                     .Inw_E(nul),.Inw_S(nul),.Inw_W(nul),
                                     .Outr_E(nul),.Outr_S(nul),.Outr_W(nul),
                                     .Outw_E(nul),.Outw_S(nul),.Outw_W(nul));
SW_IP #(DATA_WIDTH, 4'b0100, 5, FREQ) SW0100 (.dataOutE(dataInW),.Outr_E(Inr_W),.Outw_E(Inw_W),.dataInE(dataOutW),
                                     .Inr_E(Outr_W),.Inw_E(Outw_W),.clk(clk),.reset(reset),
                                     .Inr_N(nul),.Inr_S(nul),.Inr_W(nul),
                                     .Inw_N(nul),.Inw_S(nul),.Inw_W(nul),
                                     .Outr_N(nul),.Outr_S(nul),.Outr_W(nul),
                                     .Outw_N(nul),.Outw_S(nul),.Outw_W(nul));
SW_IP #(DATA_WIDTH, 4'b0101, 5, FREQ) SW0101 (.dataInE(dataInE),.dataInW(dataInW),.dataInS(dataInS),.dataInN(dataInN),
                                     .dataOutE(dataOutE),.dataOutW(dataOutW),.dataOutS(dataOutS),.dataOutN(dataOutN),
                                     .Inr_N(Inr_N),.Inr_E(Inr_E),.Inr_S(Inr_S),.Inr_W(Inr_W),
                                     .Inw_N(Inw_N),.Inw_E(Inw_E),.Inw_S(Inw_S),.Inw_W(Inw_W),
                                     .Outr_N(Outr_N),.Outr_E(Outr_E),.Outr_S(Outr_S),.Outr_W(Outr_W),
                                     .Outw_N(Outw_N),.Outw_E(Outw_E),.Outw_S(Outw_S),.Outw_W(Outw_W),
                                     .clk(clk),.reset(reset));                     
*/
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