`timescale 1 ns / 1 ns
// synopsys translate_off
// synopsys translate_on
module IP_producer
   #(
      parameter DATA_WIDTH = 37,
      parameter POSITION = 4'b0101,
      parameter FREQ = 4
       //ctntr X: 01 Y: 01
   )
(
DataOutIP,
Outr,
Outw,
clk,
//step,
reset
);

output [DATA_WIDTH-1 : 0] DataOutIP;
output Outr;
input Outw;
input clk;
input reset;
//output [1:0] step;

reg [DATA_WIDTH-1 : 0] DataOutIP;
reg Outr;
reg [1:0] step;
//reg [8:0] point;
integer point;
reg [2:0] count;
reg [3:0] dest;

initial
begin
  DataOutIP=5;
  step=0;
  point=0;
  Outr=0;
  //$display("Otput starts working at %t",$time);
end

  


always @(posedge reset or posedge clk)
	if (reset == 1'b1)
		begin
			Outr<=0;
			DataOutIP<=0;
			step=0;
			point =0;
			//if (POSITION==4'b0100) point = 5'b11111;
		end
	else
		begin 
		  //$display("IP producer position %b, Outr %b, Outw %b, at %t", POSITION, Outr, Outw, $time);
		case (step)
		    2'b00:  begin
				    //#(point)	step =  2'b01;
						if (point != 0) point = point- 1;
						  else  
						    begin
						      count= {$random} %8;
						      dest = {$random} /*%11;*/%5'b10000;
						      //dest = 4'b0000;
						      //if (dest == POSITION) dest=~dest;
							  if(POSITION!=8)
							  begin
						      case (dest)
						        //4'b0101, 4'b0000, 4'b0001, 4'b0100/*, 4'b1001*/:
						        //0,1,2,4,5,6,8,9,10: 
						        0,1,2,3,4,5,6,7/*,8/*,9,10,11*/:
						                                        if (dest != POSITION) 
						                                            begin 
						                                                          //$display("Start packet generation from source %d to destination %d at %t length %d",POSITION, dest, $time, count+1);
						                                                          $display("Stgen source: %d dest: %d len: %d time: %t ",POSITION, dest, count+1, $time);
                                                                      step=2'b01;
                                                                    end
						      endcase 
							  end
							end
						//#($random%2) step<=  1;
					end
								
				2'b01:	begin
						if (Outw==0)
				begin
						DataOutIP=$random;
						Outr=1'b1; 
						if (count == 0) 
						  begin
						    DataOutIP[4:0]={1'b1,dest};
						    //$display("Send end flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						    //step=2'b00;
						    point={$random} %50 +10;
						  end
						else 
						  begin 
						    DataOutIP[4:0]={1'b0,dest};
						    //$display("Send flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						    //count = count-1;
						    //step = 2'b10;
						  end
						  step = 2'b10;
				end
				end
        2'b10: 	begin
						if (Outw==1)
							begin
								Outr=0;
								if (count == 0) step = 2'b00;
								  else
								  begin
								    count=count-1;
								  		step=2'b01;
								  end
							end
						//step=2;
					end
		endcase
		end



endmodule

/*
`timescale 1 ns / 1 ns
// synopsys translate_off
// synopsys translate_on
module IP_producer
   #(
      parameter DATA_WIDTH = 37,
      parameter POSITION = 4'b0101,
      parameter FREQ = 4
       //ctntr X: 01 Y: 01
   )
(
DataOutIP,
Outr,
Outw,
clk,
//step,
reset
);

output [DATA_WIDTH-1 : 0] DataOutIP;
output Outr;
input Outw;
input clk;
input reset;
//output [1:0] step;

reg [DATA_WIDTH-1 : 0] DataOutIP;
reg Outr;
reg [1:0] step;
reg [5:0] point;
reg [2:0] count;
reg [3:0] dest;

initial
begin
  DataOutIP=5;
  step=0;
  point=0;
  Outr=0;
  $display("Otput starts working at %t",$time);
end

  


always @(posedge reset or posedge clk)
	if (reset == 1'b1)
		begin
			Outr<=0;
			DataOutIP<=0;
			step=0;
			point =0;
		end
	else
		begin 
		case (step)
				2'b00:  begin
				    
						//#(point)	step =  2'b01;
						if (point != 0) point = point- 1;
						  else  
						    begin
						      count= $random %7;
						      dest = $random %5'b10000;
						      if (dest == POSITION) dest=dest<<1;
			      						$display("Start packet generation from source %b to destination %b at %t",POSITION, dest, $time);
                  step=2'b01;
                end
						//#($random%2) step<=  1;
					end
				2'b01: 	begin
						if (Outr == Outw)
							begin
								Outr=0;
								step=2'b10;
							end
						//step=2;
					end
				
				2'b10:	begin
						
						DataOutIP=$random;
						Outr=1'b1; 
						if (count == 0) 
						  begin
						    DataOutIP[4:0]={1'b1,dest};
						    $display("Send end flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						    step=2'b00;
						    point=$random %FREQ;
						  end
						else 
						  begin 
						    DataOutIP[4:0]={1'b0,dest};
						    $display("Send flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						    count = count-1;
						    step = 2'b01;
						  end
				end

		endcase
		end



endmodule*/
/*
//`timescale 1 ns / 1 ns
// synopsys translate_off
// synopsys translate_on
module IP_producer
   #(
      parameter DATA_WIDTH = 37,
      parameter POSITION = 4'b0101,
      parameter FREQ = 4
       //ctntr X: 01 Y: 01
   )
(
DataOutIP,
Outr,
Outw,
clk,
//step,
reset
);

output [DATA_WIDTH-1 : 0] DataOutIP;
output Outr;
input Outw;
input clk;
input reset;
//output [1:0] step;

reg [DATA_WIDTH-1 : 0] DataOutIP;
reg Outr;
reg [1:0] step;
reg [5:0] point;
reg [2:0] count;
reg [3:0] dest;
initial
begin
  DataOutIP=5;
  step=0;
  point=0;
  Outr=0;
  $display("Otput starts working at %t",$time);
end

  


always @(posedge reset or posedge clk)
	if (reset == 1'b1)
		begin
			Outr<=0;
			DataOutIP<=0;
			step<=0;
		end
	else
		begin 
		case (step)
				2'b00:  begin
				    point=$random %FREQ;
						#(point)	step =  2'b01;
						count= $random %7;
						dest = $random %5'b10000;
						if (dest == POSITION) dest=dest<<1;
						$display("Start packet generation from source %b to destination %b at %t",POSITION, dest, $time);
						//#($random%2) step<=  1;
					end
				2'b01: 	begin
						if (Outr == Outw)
							begin
								Outr=0;
								step=2'b10;
							end
						//step=2;
					end
				
				2'b10:	begin
						
						DataOutIP=$random;
						if (count == 0) 
						  begin
						    DataOutIP[4:0]={1'b1,dest};
						    step=2'b00;
						    $display("Send end flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						  end
						else 
						  begin 
						    DataOutIP[4:0]={1'b0,dest};
						    $display("Send flit %b #%d, source %b, destination %b at %t",DataOutIP, count, POSITION, dest, $time); 
						    count = count-1;
						    step = 2'b01;
						  end
						Outr=1; 
					end

		endcase
		end



endmodule
*/