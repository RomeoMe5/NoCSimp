//rev 2 all works correct
//rev 2 all works correct

module InPort 
   #(
        parameter DATA_WIDTH = 37,
        parameter POSITION = 4'b0101 //ctntr X: 01 Y: 01 
   )
(
dataInE, 
dataInW,
dataInS,
dataInN,
dataInL,
clk,
full,
reset,
Inr_L,Inr_N,Inr_E,Inr_S,Inr_W,
Inw_L,Inw_N,Inw_E,Inw_S,Inw_W,
DataFiFo,
wrreq
);

input [DATA_WIDTH-1:0]  dataInE, dataInW, dataInS, dataInN, dataInL;
input full;
input reset;
input clk;
input Inr_L,Inr_N,Inr_E,Inr_S,Inr_W;
output Inw_L,Inw_N,Inw_E,Inw_S,Inw_W;
output [DATA_WIDTH-1:0] DataFiFo;
output wrreq;
reg wrreq;
reg [DATA_WIDTH-1:0] DataFiFo;
reg [1:0] step;	/////////!!!!! can be 1 bit!!!
reg [2:0] port;
reg [4:0] Inw;
wire [4:0] Inr;

assign Inr = {Inr_L,Inr_N,Inr_E,Inr_S,Inr_W};
assign {Inw_L,Inw_N,Inw_E,Inw_S,Inw_W} = Inw;

always @(posedge clk or posedge reset)
begin
	if (reset == 1'b1)
        begin
			step<=0;
			port<=0;
			wrreq<=0;
			Inw<=0;
			DataFiFo<=0;
		end
    else
		begin
			 ///*if (POSITION==4'b0101)*/ $display("SW %b: step %b, Inr %b, Inw %b time %t", POSITION, step, Inr, Inw, $time);
			case (step)
				0:  begin
						if (full) $display("SW full %b", POSITION);
						//else if (Inr > 0)
						if ((!full) && (Inr > 0))
							/*begin
							  $display("SW %b looking", POSITION);
								if (Inr[0] == 1'b1)
									begin
										Inw<=1'b1;
										DataFiFo<=dataInW;
										$display("SW %b: Received flit %b, from W at %t", POSITION, dataInW, $time);
									end
								else if (Inr[1] == 1'b1)
									begin
										Inw<=(1'b1<<1);
										DataFiFo<=dataInS;
										$display("SW %b: Received flit %b, from S at %t", POSITION, dataInS, $time);
									end
								else if (Inr[2] == 1'b1)
									begin
										Inw<=(1'b1<<2);
										DataFiFo<=dataInE;
										$display("SW %b: Received flit %b, from E at %t", POSITION, dataInE, $time);
									end
								else if (Inr[3] == 1'b1)
									begin
										Inw<=(1'b1<<3);
										DataFiFo<=dataInN;
										$display("SW %b: Received flit %b, from N at %t", POSITION, dataInN, $time);
									end
								else if (Inr[4] == 1'b1)
									begin
										Inw<=(1'b1<<4);
										DataFiFo=dataInL;
										$display("SW %b: Received flit %b, from L at %t", POSITION, dataInL, $time);
									end
									wrreq<=1'b1;
									step=1;
							end
							*/
							begin
								//$display("SW %b looking", POSITION);
								if (Inr[port] != 1'b1)
									begin
										//if (port==4) port = 0;
										//else port=port+1;
										port=(port+1)%5;
										if (Inr[port] != 1'b1)
										begin
										  port=(port+1)%5;
										  if (Inr[port] != 1'b1)
										  begin
										    port=(port+1)%5;
										    if (Inr[port] != 1'b1)
										    begin
										      port=(port+1)%5;
										      if (Inr[port] != 1'b1)
										      port=(port+1)%5;
										    end
										  end
										end
									end
							  else
								//if (Inr[port] == 1'b1) 
									begin
										Inw<=(1'b1 << port);
										case (port)
											0: DataFiFo=dataInW;
											1: DataFiFo=dataInS;
											2: DataFiFo=dataInE;
											3: DataFiFo=dataInN;
											4: DataFiFo=dataInL;	
										endcase
										//$display("SW %d: Received flit %b, from port %d at %t", POSITION, DataFiFo, port, $time);
										$display("SW %d: Received flit at time: %t to %d", POSITION, $time, DataFiFo[3:0]);
										wrreq<=1'b1;
										step=1;
									end
							end
														
							
					end	
				1:  begin
				    
						wrreq<=1'b0;
						if (Inr[port] == 1'b0) 
							begin 
								Inw<=0;
								if (DataFiFo[4] == 1'b1) 
								  begin 
								    step=0; 
								    port=(port+1)%5; 
								  end
								else step = 2; 									
							end
					end
				2:  begin
				      if (Inr[port] == 1'b1) step =1'b0;
				    end
				
			endcase
		end
	
end
endmodule
/*module InPort 
   #(
        parameter DATA_WIDTH = 37 
   )
(
dataInE, 
dataInW,
dataInS,
dataInN,
dataInL,
clk,
full,
reset,
Inr_L,Inr_N,Inr_E,Inr_S,Inr_W,
Inw_L,Inw_N,Inw_E,Inw_S,Inw_W,
DataFiFo,
wrreq
);

input [DATA_WIDTH-1:0]  dataInE, dataInW, dataInS, dataInN, dataInL;
input full;
input reset;
input clk;
input Inr_L,Inr_N,Inr_E,Inr_S,Inr_W;
output Inw_L,Inw_N,Inw_E,Inw_S,Inw_W;
output [DATA_WIDTH-1:0] DataFiFo;
output wrreq;
reg wrreq;
reg [DATA_WIDTH-1:0] DataFiFo;
reg step;	/////////!!!!! can be 1 bit!!!
reg [2:0] port;
reg [4:0] Inw;
wire [4:0] Inr;

assign Inr = {Inr_L,Inr_N,Inr_E,Inr_S,Inr_W};
assign {Inw_L,Inw_N,Inw_E,Inw_S,Inw_W} = Inw;

always @(posedge clk or posedge reset)
begin
	if (reset == 1'b1)
        begin
			step<=0;
			port<=0;
			wrreq<=0;
			Inw<=0;
			DataFiFo<=0;
		end
    else
		begin
			case (step)
				
				0:  begin
						if ((!full)&&(Inr > 0)) 
							begin
								if ((DataFiFo[4] == 1'b1) || (Inr[port] != 1'b1))
									begin
										if (port==4) port = 0;
										else port=port+1;
									end
								if (Inr[port] == 1'b1) 
									begin
										Inw<=(1'b1 << port);
										case (port)
											0: DataFiFo=dataInW;
											1: DataFiFo=dataInS;
											2: DataFiFo=dataInE;
											3: DataFiFo=dataInN;
											4: DataFiFo=dataInL;	
										endcase
										$display("SW %b: Received flit %b, from %d at %t", 4'b0101, DataFiFo, port, $time);
										wrreq<=1'b1;
										step=1;
									end
							end							
					end	
				1:  begin
				    
						wrreq<=1'b0;
						if (Inr[port] == 1'b0) 
							begin 
								Inw<=0;
								step=0; 									
							end
					end
			endcase
		end
	
end
endmodule
*/