`timescale 1 ns / 1 ns
// synopsys translate_on
module NoC_special
   #(  parameter DATA_WIDTH = 37,
       parameter FREQ = 2,
       parameter N =2 
    )
();

reg clk;
reg reset;
reg [31 : 0] t;

initial 
begin 
  $display("Start simulation at %t",$time); 
  clk=0;
  reset=0;
  #(10) reset =1'b1;
  #(10) reset =1'b0;
  t=0;
end
always
begin
  #1 clk=~clk;
  t=t+1;//$time;
  //$display("time: %d", t);
  if (t>2020) $stop;
end

wire [DATA_WIDTH-1 : 0] dataIn[N*N-1 : 0][3 : 0];
wire [DATA_WIDTH-1 : 0] dataOut[N*N-1 : 0][3 : 0];
wire  Inr [N*N-1 : 0][3 :0];
wire  Inw [N*N-1 : 0][3 :0];
wire  Outr [N*N-1 : 0][3 :0];
wire  Outw [N*N-1 : 0][3 :0];

//reg [7:0] dd [1:0] = '{1,1};


assign dataIn[0][0] = '0;
assign Inr[0][0] = '0;
assign Outw[0][0] = '0;

assign dataIn[0][1] = dataOut[2][3];
assign Inr[0][1] = Outr[2][3];
assign Outw[0][1] = Inw[2][3];

assign dataIn[0][2] = dataOut[1][0];
assign Inr[0][2] = Outr[1][0];
assign Outw[0][2] = Inw[1][0];

assign dataIn[0][3] = '0;
assign Inr[0][3] = '0;
assign Outw[0][3] = '0;

assign dataIn[1][0] = dataOut[0][2];
assign Inr[1][0] = Outr[0][2];
assign Outw[1][0] = Inw[0][2];

assign dataIn[1][1] = dataOut[3][3];
assign Inr[1][1] = Outr[3][3];
assign Outw[1][1] = Inw[3][3];

assign dataIn[1][2] = '0;
assign Inr[1][2] = '0;
assign Outw[1][2] = '0;

assign dataIn[1][3] = '0;
assign Inr[1][3] = '0;
assign Outw[1][3] = '0;

assign dataIn[2][0] = '0;
assign Inr[2][0] = '0;
assign Outw[2][0] = '0;

assign dataIn[2][1] = '0;
assign Inr[2][1] = '0;
assign Outw[2][1] = '0;

assign dataIn[2][2] = dataOut[3][0];
assign Inr[2][2] = Outr[3][0];
assign Outw[2][2] = Inw[3][0];

assign dataIn[2][3] = dataOut[0][1];
assign Inr[2][3] = Outr[0][1];
assign Outw[2][3] = Inw[0][1];

assign dataIn[3][0] = dataOut[2][2];
assign Inr[3][0] = Outr[2][2];
assign Outw[3][0] = Inw[2][2];

assign dataIn[3][1] = '0;
assign Inr[3][1] = '0;
assign Outw[3][1] = '0;

assign dataIn[3][2] = '0;
assign Inr[3][2] = '0;
assign Outw[3][2] = '0;

assign dataIn[3][3] = dataOut[1][1];
assign Inr[3][3] = Outr[1][1];
assign Outw[3][3] = Inw[1][1];




genvar x;
generate
begin
  for (x=0;x<N*N;x=x+1)
    begin
         SW_IP #(DATA_WIDTH, x, 7, FREQ) node (.dataInW(dataIn[x][0]),.dataInS(dataIn[x][1]),.dataInE(dataIn[x][2]),.dataInN(dataIn[x][3]),
                                     .dataOutW(dataOut[x][0]),.dataOutS(dataOut[x][1]),.dataOutE(dataOut[x][2]),.dataOutN(dataOut[x][3]),
                                     .Inr_W(Inr[x][0]),.Inr_S(Inr[x][1]),.Inr_E(Inr[x][2]),.Inr_N(Inr[x][3]),
                                     .Inw_W(Inw[x][0]),.Inw_S(Inw[x][1]),.Inw_E(Inw[x][2]),.Inw_N(Inw[x][3]),
                                     .Outr_W(Outr[x][0]),.Outr_S(Outr[x][1]),.Outr_E(Outr[x][2]),.Outr_N(Outr[x][3]),
                                     .Outw_W(Outw[x][0]),.Outw_S(Outw[x][1]),.Outw_E(Outw[x][2]),.Outw_N(Outw[x][3]),
                                     .clk(clk),.reset(reset));

     end
end
endgenerate
endmodule