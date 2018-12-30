module OutPort 
   #(
        parameter DATA_WIDTH = 37, 
        parameter POSITION = 4'b0101 //ctntr X: 01 Y: 01
   )
(
dataOutE, 
dataOutW,
dataOutS,
dataOutN,
dataOutL,
Outr_L,Outr_N,Outr_E,Outr_S,Outr_W,
Outw_L,Outw_N,Outw_E,Outw_S,Outw_W,
DataFiFo,
rdreq,
clk,
empty,
reset
);

output [DATA_WIDTH-1:0]  dataOutE, dataOutW, dataOutS, dataOutN, dataOutL;
input empty;
input reset;
input clk;
output Outr_L,Outr_N,Outr_E,Outr_S,Outr_W;
input Outw_L,Outw_N,Outw_E,Outw_S,Outw_W;
input [DATA_WIDTH-1:0] DataFiFo;
output rdreq;
reg rdreq;
reg [DATA_WIDTH-1:0]  dataOutE, dataOutW, dataOutS, dataOutN, dataOutL;
reg [1:0] step;	/////////!!!!! can be 1 bit!!!
//reg [2:0] port;
reg [4:0] Outr;
wire [4:0] Outw;

reg [2:0] routes[8:0][8:0];
initial
begin
  routes[0][0]=4;   routes[0][1]=0;   routes[0][2]=0;   routes[0][3]=0;   routes[0][4]=1;   routes[0][5]=1;   routes[0][6]=1;   routes[0][7]=1; 
  routes[1][0]=0;   routes[1][1]=4;   routes[1][2]=1;   routes[1][3]=2;   routes[1][4]=1;   routes[1][5]=2;   routes[1][6]=2;   routes[1][7]=0; 
  routes[2][0]=0;   routes[2][1]=0;   routes[2][2]=4;   routes[2][3]=1;   routes[2][4]=2;   routes[2][5]=1;   routes[2][6]=1;   routes[2][7]=2; 
  routes[3][0]=0;   routes[3][1]=0;   routes[3][2]=1;   routes[3][3]=4;   routes[3][4]=1;   routes[3][5]=2;   routes[3][6]=3;   routes[3][7]=2; 
  routes[4][0]=1;   routes[4][1]=0;   routes[4][2]=0;   routes[4][3]=0;   routes[4][4]=4;   routes[4][5]=1;   routes[4][6]=1;   routes[4][7]=1; 
  routes[5][0]=1;   routes[5][1]=0;   routes[5][2]=0;   routes[5][3]=0;   routes[5][4]=1;   routes[5][5]=4;   routes[5][6]=0;   routes[5][7]=1; 
  routes[6][0]=1;   routes[6][1]=0;   routes[6][2]=0;   routes[6][3]=0;   routes[6][4]=1;   routes[6][5]=0;   routes[6][6]=4;   routes[6][7]=1; 
  routes[7][0]=0;   routes[7][1]=0;   routes[7][2]=1;   routes[7][3]=3;   routes[7][4]=1;   routes[7][5]=2;   routes[7][6]=3;   routes[7][7]=4; 
end


assign Outw = {Outw_L,Outw_N,Outw_E,Outw_S,Outw_W};
assign {Outr_L,Outr_N,Outr_E,Outr_S,Outr_W} = Outr;

always @(posedge clk or posedge reset)
//always @(negedge clk or posedge reset)
begin
	if (reset == 1'b1)
        begin
			step<=0;
//			port<=0;
			rdreq<=0;
			Outr<=0;
			
		end
    else
		begin
		  ///*if (POSITION==4'b0100)*/ $display("SW %b: step %b, outr %b, outw %b time %t", POSITION, step, Outr, Outw, $time);
			case (step)
				2'b00:  if (!empty)
							begin
								rdreq<=1;
								step=2'b01;
								//$display("step1 sw %b", POSITION);
							end
							//else $display("SW empty %b", POSITION);
				2'b01: 	begin
						rdreq<=0;
						if (Outr == Outw)
							begin
								Outr<=0;
								step=2'b10;
								//$display("step2 sw %b", POSITION);
							end
						//step=2;
					end
				2'b10:  begin
				        case (routes[POSITION][DataFiFo[3:0]])
  				          0: begin Outr = 5'b00001; dataOutW=DataFiFo; end
				          1: begin Outr = 5'b00010; dataOutS=DataFiFo; end
				          2: begin Outr = 5'b00100; dataOutE=DataFiFo; end				  				        
				          3: begin Outr = 5'b01000; dataOutN=DataFiFo; end
				          4: begin Outr = 5'b10000; dataOutL=DataFiFo; end			
				        endcase	        				                
				        //$display("step3 sw %b", POSITION);
																		//XY routing//
								//if (DataFiFo [1:0] > POSITION[1:0]) begin Outr = 5'b00100; dataOutE=DataFiFo; /*$display("SW %b: Send flit %b, to E %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);*/end //Inr ^ 4'b00100; //E
								//else if (DataFiFo [1:0] < POSITION[1:0]) begin Outr = 5'b00001; dataOutW=DataFiFo; /*$display("SW %b: Send flit %b, to W %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);*/end //W
								//     else if (DataFiFo [3:2] < POSITION[3:2]) begin Outr = 5'b01000; dataOutN=DataFiFo; /*$display("SW %b: Send flit %b, to N %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);*/end //N
								//          else if (DataFiFo [3:2] > POSITION[3:2]) begin Outr = 5'b00010; dataOutS=DataFiFo; /*$display("SW %b: Send flit %b, to S %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);*/end //S
								//			   else begin Outr=5'b10000; dataOutL=DataFiFo; /*$display("SW %b: Send flit %b, to L %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);*/end //L
								//$display("SW %b: Send flit %b, to %b at %t", POSITION, DataFiFo, DataFiFo [3:0], $time);
                $display("SW %d: Send flit at time: %t to %d", POSITION, $time, DataFiFo[3:0]);
								step=2'b11;
								end
				2'b11: if (Outr == Outw) begin Outr<=0; step=2'b00; end


			endcase
		end
end				
endmodule//*/
/*module OutPort 
   #(
        parameter DATA_WIDTH = 37, 
        parameter position = 4'b0101 //ctntr X: 01 Y: 01
   )
(
dataOutE, 
dataOutW,
dataOutS,
dataOutN,
dataOutL,
Outr_L,Outr_N,Outr_E,Outr_S,Outr_W,
Outw_L,Outw_N,Outw_E,Outw_S,Outw_W,
DataFiFo,
rdreq,
clk,
empty,
reset
);

output [DATA_WIDTH-1:0]  dataOutE, dataOutW, dataOutS, dataOutN, dataOutL;
input empty;
input reset;
input clk;
output Outr_L,Outr_N,Outr_E,Outr_S,Outr_W;
input Outw_L,Outw_N,Outw_E,Outw_S,Outw_W;
input [DATA_WIDTH-1:0] DataFiFo;
output rdreq;
reg rdreq;
reg [DATA_WIDTH-1:0]  dataOutE, dataOutW, dataOutS, dataOutN, dataOutL;
reg [1:0] step;	/////////!!!!! can be 1 bit!!!
//reg [2:0] port;
reg [4:0] Outr;
wire [4:0] Outw;

assign Outw = {Outw_L,Outw_N,Outw_E,Outw_S,Outw_W};
assign {Outr_L,Outr_N,Outr_E,Outr_S,Outr_W} = Outr;

always @(posedge clk or posedge reset)
begin
	if (reset == 1'b1)
        begin
			step<=0;
//			port<=0;
			rdreq<=0;
			Outr<=0;
			
		end
    else
		begin
			case (step)
				0:  if (!empty)
							begin
								rdreq<=1;
								step=1;
								$display("SW %b: step %b, time %t", 4'b0101, step, $time);
							end
				1: 	begin
						rdreq<=0;
						if (Outw==5'b00000)
							begin
								//Outr<=0;
								step=2;
								$display("SW %b: step %b, time %t", 4'b0101, step, $time);
							end
						//step=2;
					end
				2:  begin
				        $display("SW %b: step %b, time %t", 4'b0101, step, $time);
																		//XY routing//
								if (DataFiFo [1:0] > position[1:0]) begin Outr <= 5'b00100; dataOutE<=DataFiFo; end //Inr ^ 4'b00100; //E
								else if (DataFiFo [1:0] < position[1:0]) begin Outr <= 5'b00001; dataOutW<=DataFiFo; end //W
								     else if (DataFiFo [3:2] > position[3:2]) begin Outr <= 5'b01000; dataOutN<=DataFiFo; end //N
								          else if (DataFiFo [3:2] < position[3:2]) begin Outr <= 5'b00010; dataOutS<=DataFiFo; end //S
											   else begin Outr<=5'b10000; dataOutL<=DataFiFo; end //L
								$display("SW %b: Send flit %b, to %b at %t", 4'b0101, DataFiFo, DataFiFo [3:0], $time);
								step=3;
					end
				3:  begin
				      if (Outw==Outr) 
				      begin
				        Outr=0;
				        step=0;
				      end
				  
				    end

			endcase
		end
end				
endmodule

*/
