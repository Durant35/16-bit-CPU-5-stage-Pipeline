
/*==================================================
       Name: CPU-top.
	Function: conbimed with instruction-memory 
	          and data memeory, 
			 used to test the core module
                                    ---- mips.			 
====================================================*/

`timescale 1ns / 1ps

module cpu_top(
   input clk, r_st,        // clock and reset signal.
	input start, enable,    // use for CPU's state control.
   input[3:0] select_y,    // select_y and y no used tempoary.
	output[15:0] y
);

   wire [15:0] i_datain;   // the content of the instruction.
	wire [15:0] d_datain;   // the data read from the data memory.
	wire [15:0] i_addr;     // the address of the instruction.
	wire [15:0] d_addr;     // the address of the data(to store or to read).
	wire [15:0] d_dataout;  // the data to store.
	wire d_we;              // store enable for data memory.
	
//================= Core-Mips =====================
   mips core(
		.clk(clk), 
		.r_st(r_st), 
		.start(start), 
		.enable(enable), 
		.i_datain(i_datain), 
		.d_datain(d_datain), 
		.i_addr(i_addr), 
		.d_addr(d_addr), 
		.d_dataout(d_dataout), 
		.d_we(d_we),
		.select_y(select_y),
		.y(y)
	);	
//================================================= 
	
//================= Instruction Memory ============
 instruction_memory 
  i_mem(.r_st(r_st),
		  .i_addr(i_addr),
		  .i_out(i_datain)
		  );
//================================================= 

//================== Data Memory ==================
 data_memory 
 d_mem(.r_st(r_st),
       .d_addr(d_addr),
		 .d_we(d_we),
		 .d_wdata(d_dataout),
		 .d_dataout(d_datain)
		 );
//=================================================

endmodule
