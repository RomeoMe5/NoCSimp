module sync_fifo
   #(
      parameter DATA_WIDTH = 37,
      parameter LOG2_DEPTH = 5 // i.e. fifo depth=2**LOG2_DEPTH
   )
   (
      input [DATA_WIDTH-1:0]  din,
      input wr_en,
      input rd_en,
      output reg [DATA_WIDTH-1:0] dout,
      output full,
      output empty,
      input clk,
      input reset
	  //output [LOG2_DEPTH-1 : 0] depth
   );

   parameter MAX_COUNT = 2**LOG2_DEPTH;
   reg   [LOG2_DEPTH-1 : 0]   rd_ptr;
   reg   [LOG2_DEPTH-1 : 0]   wr_ptr;
   reg   [DATA_WIDTH-1 : 0]   mem[MAX_COUNT-1 : 0];   //memory size: 2**LOG2_DEPTH
   reg   [LOG2_DEPTH-1 : 0]     depth_cnt;
   

   always @(posedge clk) begin
      if(reset) begin
         wr_ptr <= 'h0;
         rd_ptr <= 'h0;
      end // end if
      else begin
         if(wr_en)begin
            wr_ptr <= wr_ptr+1;
         end
         if(rd_en)
            rd_ptr <= rd_ptr+1;
      end //end else
   end//end always

   assign empty= (depth_cnt=='h0);
   assign full = (depth_cnt==MAX_COUNT-1);
   //assign depth = depth_cnt;

   //comment if you want a registered dout
   //assign dout = rd_en ? mem[rd_ptr]:'h0;
	//assign dout = mem[rd_ptr];
   always @(posedge clk) begin
      if (wr_en)
         mem[wr_ptr] <= din;
   end //end always

   //uncomment if you want a registered dout
   always @(posedge clk) begin
      if (reset)
         dout <= 'h0;
      else if (rd_en)
         dout <= mem[rd_ptr];
   end

   always @(posedge clk) begin
      if (reset)
         depth_cnt <= 'h0;
      else begin
         case({rd_en,wr_en})
            2'b10    :  depth_cnt <= depth_cnt-1;
            2'b01    :  depth_cnt <= depth_cnt+1;
         endcase
      end //end else
   end //end always

endmodule

/*
module sync_fifo
   #(
      parameter DATA_WIDTH = 37,
      parameter LOG2_DEPTH = 5 // i.e. fifo depth=2**LOG2_DEPTH
   )
   (
      input [DATA_WIDTH-1:0]  din,
      input wr_en,
      input rd_en,
      output reg [DATA_WIDTH-1:0] dout,
      output full,
      output empty,
      input clk,
      input reset
	  //output [LOG2_DEPTH-1 : 0] depth
   );

   parameter MAX_COUNT = 2**LOG2_DEPTH;
   reg   [LOG2_DEPTH-1 : 0]   rd_ptr;
   reg   [LOG2_DEPTH-1 : 0]   wr_ptr;
   reg   [DATA_WIDTH-1 : 0]   mem[MAX_COUNT-1 : 0];   //memory size: 2**LOG2_DEPTH
   reg   [LOG2_DEPTH-1 : 0]     depth_cnt;
   

   always @(clk) begin
      if(reset) begin
         wr_ptr <= 'h0;
         rd_ptr <= 'h0;
      end // end if
      else begin
         if(wr_en)begin
            wr_ptr <= wr_ptr+1;
         end
         if(rd_en)
            rd_ptr <= rd_ptr+1;
      end //end else
   end//end always

   assign empty= (depth_cnt=='h0);
   assign full = (depth_cnt==MAX_COUNT-1);
   //assign depth = depth_cnt;

   //comment if you want a registered dout
   //assign dout = rd_en ? mem[rd_ptr]:'h0;
	//assign dout = mem[rd_ptr];
   always @(clk) begin
      if (wr_en)
         mem[wr_ptr] <= din;
   end //end always

   //uncomment if you want a registered dout
   always @(clk) begin
      if (reset)
         dout <= 'h0;
      else if (rd_en)
         dout <= mem[rd_ptr];
   end

   always @(clk) begin
      if (reset)
         depth_cnt <= 'h0;
      else begin
         case({rd_en,wr_en})
            2'b10    :  depth_cnt <= depth_cnt-1;
            2'b01    :  depth_cnt <= depth_cnt+1;
         endcase
      end //end else
   end //end always

endmodule

*/