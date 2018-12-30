//`timescale 1 ns / 1 ns
// synopsys translate_off
// synopsys translate_on
module IP_consumer
   #(
      parameter DATA_WIDTH = 37,
      parameter POSITION = 4'b0101 //ctntr X: 01 Y: 01
   )
(
DataInIP,
Inr,
Inw,
clk,
//step,
reset
);

input [DATA_WIDTH-1 : 0] DataInIP;
output Inw;
input Inr;
input clk;
input reset;
//output [1:0] step;

//reg [DATA_WIDTH-1 : 0] DataOutIP;
reg Inw;
reg /*[1:0]*/ step;
reg [5:0] point;
reg [2:0] count;

initial
begin
  step=0;
  point=0;
  Inw=0;
  //$display("Input starts working at %t",$time);
end

always @(posedge reset or posedge clk)
//always @(posedge reset or negedge clk)
begin
	if (reset == 1'b1)
    begin
      step<=0;
      Inw<=0;
      count<=0;
    end
    else
    begin
      // $display("IP consumer position %b, Inr %b, Inw %b, at %t", POSITION, Inr, Inw, $time);
      case (step)
        
        1'b0:  begin
            if (Inr == 1'b1) 
                  begin
                    Inw=1'b1;
                    step=1'b1;
                  end
            end							
        1'b1:  begin
            if (Inr == 1'b0) 
              begin 
                //$display("Recv pos: %d len: %d time: %t", POSITION, count+1, $time);
				if (DataInIP[3:0]!=POSITION) $display("ERROR: Received not suited flit. Aim is %b, but position is %b", DataInIP[3:0], POSITION);
                if (DataInIP[4]==1'b1) 
                  begin
                    //$display("Received end flit position %d at %t message length %d", POSITION, $time, count+1);
                    $display("Recv pos: %d len: %d time: %t", POSITION, count+1, $time);
                    //$display("Received end flit %b, position %d at %t",DataInIP, POSITION, $time);
                    //$display("Message length %d",count);
                    count=0;
                  end
                  else 
                    begin
                      //$display("Received flit %b, position %b at %t",DataInIP, POSITION, $time);
                      count=count+1;
                    end
                Inw=1'b0;
                step=1'b0; 									
              end
            end
      endcase
    end
end
endmodule