
/* ================ Test Bench ==============
     Name: mips's test bench.
 Function: test the design of mips through 
         text simulation of the top-module
			cpu_top.
 ============================================ */

`timescale 1ns / 1ps

module cpu_tb;

// ************* Operations Define ********** //
// Data transfer & Arithmetic operations
`define NOP 5'd0
`define HALT 5'd1
`define LOAD 5'd26
`define STORE 5'd2
`define LDIH 5'd3
`define ADD 5'd4
`define ADDI 5'd5
`define ADDC 5'd6
`define SUB 5'd7
`define SUBI 5'd8
`define SUBN 5'd9
`define CMP 5'd10
// Logical & Shift operations
`define AND 5'd11
`define OR 5'd12
`define XOR 5'd13
`define SLL 5'd14
`define SRL 5'd15
`define SLA 5'd16
`define SRA 5'd17
// Control operations
`define JUMP 5'd18
`define JMPR 5'd19
`define BZ 5'd20
`define BNZ 5'd21
`define BN 5'd22
`define BNN 5'd23
`define BC 5'd24
`define BNC 5'd25
// ************* Gr-index Define ********** //
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111

	// Inputs
	reg clk;
	reg r_st;
	reg start;
	reg enable;
	reg [3:0] select_y;

	// Outputs
	wire [15:0] y;

	// Instantiate the Unit Under Test (UUT)
	cpu_top uut (
		.clk(clk), 
		.r_st(r_st), 
		.start(start), 
		.enable(enable), 
		.select_y(select_y), 
		.y(y)
	);
   
	always#5 clk = ~clk;           
	                // make a clock of 100MHz.
   
	initial begin
		// Initialize Inputs
		clk = 0;
		r_st = 0;
		start = 0;
		enable = 0;
		select_y = 0;
		uut.core.gr[`gr0] = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("%.5t   %h  %b  %h    %h      %h       %b      %h     %h  %h  %h  %h  %h  %h  %h  %h   %b     %b      %b     %h    %b       %h      %h       %h",
  		     $time, uut.core.pc, uut.core.id_ir, uut.core.reg_A, uut.core.reg_B, uut.core.reg_C, uut.core.d_we, uut.core.reg_C1,
			  uut.core.gr[0], uut.core.gr[1], uut.core.gr[2], uut.core.gr[3], uut.core.gr[4], uut.core.gr[5], uut.core.gr[6], 
			  uut.core.gr[7], uut.core.cf, uut.core.zf, uut.core.nf, uut.i_addr, uut.i_datain, uut.d_addr, uut.d_datain, uut.core.smdr);
      $display("Time/ps IF-pc     IF-id_ir     ID-reg_A ID-reg_B EX-reg_C EX-d_we MEM-reg_C1   gr0   gr1   gr2   gr3   gr4   gr5   gr6   gr7 EX-cf EX-zf EX-nf IF-i_addr    IF-i_datain     MEM-d_addr MEM-d_datain ID-smdr");
		#10 r_st = 1;
		#10 r_st = 0;
		#10 enable = 1;
		#10 start = 1;
		#10 start = 0;	
	end 
endmodule
