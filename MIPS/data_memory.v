
/* ================ Data Memory =============
     Name: Data Memory, store all data.
 Function: 1. store the result after operations.
           2. transfer data to operate.
 ============================================*/

`timescale 1ns / 1ps
`define SIZE (2 ** 4)

// conbimation logic, without any clock.
module data_memory (
   input r_st,             // reset signal.
   input[15:0] d_addr,     // the address of the data(to store or to read).
	input d_we,             // store enable for data memory.
	input[15:0] d_wdata,    // the data to store.
	output[15:0] d_dataout  // the data read from the data memory.
);

reg[15:0] data[`SIZE - 1 :0]; // set memory.
reg[15:0] data_o; 
always@(*)
   begin
	  if(r_st) 
	     begin
		    data_o <= 16'b0000_0000_0000_0000;
			 data[0] <= 16'h3c00;
          data[1] <= 16'hffff; // 3c00 + ffff = 3bff(½øÎ»1)
          data[2] <= 16'h3cab;
          data[3] <= 16'haaaa; // 3cab - aaaa = 9201(½èÎ»1)
			 data[4] <= 16'b0000_0000_0000_0000;
			 data[5] <= 16'b0000_0000_0000_0000;
			 data[6] <= 16'b0000_0000_0000_0000;
          data[7] <= 16'b0000_0000_0000_0000;
			 data[8] <= 16'b0000_0000_0000_0000;
			 data[9] <= 16'b0000_0000_0000_0000;
			 data[10] <= 16'b0000_0000_0000_0000;
			 data[11] <= 16'b0000_0000_0000_0000;
			 data[12] <= 16'b0000_0000_0000_0000;
			 data[13] <= 16'b0000_0000_0000_0000;
			 data[14] <= 16'b0000_0000_0000_0000;
			 data[15] <= 16'b0000_0000_0000_0000;
		  end
	  else 
	    begin
		   if(d_we) data[d_addr] <= d_wdata;
			else data_o <= data[d_addr];
       end			
	end

assign d_dataout = data_o; 

endmodule
