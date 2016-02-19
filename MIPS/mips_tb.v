`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:22:43 12/16/2013
// Design Name:   mips
// Module Name:   D:/Xilinx/12.3/workspace/Week12/MIPS/mips_tb.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

// ***************************** Operations Define **************************** //
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
// ***************************** Gr-index Define **************************** //
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
	
	wire [15:0] i_datain;
	wire [15:0] d_datain;

	// Outputs
	wire [15:0] i_addr;
	wire [15:0] d_addr;
	wire [15:0] d_dataout;
	wire [15:0] y;
	wire d_we;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
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
//========= Instruction Memory ============
 instruction_memory 
     u1(.clk(clk),
		  .r_st(r_st),
		  .i_addr(pc),
		  .i_out(i_datain)
		  );
//========================================== 

//================== Data Memory==================
 data_memory 
    u2(.clk(clk),
       .r_st(r_st),
       .d_addr(d_addr),
		 .d_we(d_we),
		 .d_wdata(d_dataout),
		 .d_dataout(d_datain)
		 );
//=================================================

   always#5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		r_st = 0;
		start = 0;
		enable = 0;
		/*i_datain = 0;
		d_datain = 0;*/
		select_y = 0;
		uut.gr[`gr0] = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

$monitor("%.5t   %h  %b  %h  %h  %h   %b   %h   %h  %h  %h  %h  %h  %h  %h  %h %b    %h", $time, uut.pc, uut.id_ir, 
 uut.reg_A, uut.reg_B, uut.reg_C, uut.d_we, uut.reg_C1, uut.gr[0], uut.gr[1], uut.gr[2], uut.gr[3], 
 uut.gr[4], uut.gr[5], uut.gr[6], uut.gr[7], uut.cf, uut.d_datain);
 
 $display("Test ADD");
 $display("Time/ps  pc      id_ir        reg_A reg_B reg_C d_we reg_C1   gr0   gr1   gr2   gr3   gr4   gr5   gr6   gr7 CF d_datain");
		#10 r_st = 1;
		#10 r_st = 0;
		#10 enable = 1;
		#10 start = 1;
		#10 start = 0;	
		    i_datain = {`LOAD, `gr1, 1'b1, `gr0, 4'b0000};			       #10 i_datain = {`LOAD, `gr2, 1'b1, `gr0, 4'b0001};
      #10 i_datain = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};			 				
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		#10 i_datain = {`ADD, `gr5, 1'b0, `gr1, 1'b0, `gr4};
		#10 i_datain = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
      #10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000};
      #10 i_datain = {`HALT, 11'b000_0000_0000};*/		
		
 $display("Test ADD to set CF");
 $display(" Time/ps  pc      id_ir         reg_A reg_B reg_C d_we d_addr d_dataout  reg_C1  gr0   gr1   gr2   gr3   gr4   gr5   gr6   gr7 CF");
		#10 r_st = 1;
		#10 r_st = 0;
		#10 enable = 1;
		#10 start = 1;
		#10 start = 0;	                                       // LOAD gr0 gr0 0
		    i_datain = {`LOAD, `gr0, 1'b1, `gr0, 4'b0000};       #10 i_datain = {`LOAD, `gr1, 1'b1, `gr0, 4'b0001};    // LOAD gr0 gr0 1
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; // 3 clock after Load
		    d_datain = 16'hf000;
		#10 i_datain = {`NOP, 11'b000_0000_0000}; // 3 clock after Load
		    d_datain = 16'hf00f;      #10 i_datain = {`ADD, `gr2, 1'b0, `gr0, 1'b0, `gr1};       #10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		
		#10 i_datain = {`LOAD, `gr3, 1'b1, `gr0, 4'b0000};       #10 i_datain = {`LOAD, `gr4, 1'b1, `gr0, 4'b0001}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		    d_datain = 16'hf000;
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		    d_datain = 16'h000f;       #10 i_datain = {`ADD, `gr5, 1'b0, `gr1, 1'b0, `gr2};
		
		#10 i_datain = {`LOAD, `gr3, 1'b1, `gr0, 4'b0000};       #10 i_datain = {`LOAD, `gr4, 1'b1, `gr0, 4'b0001}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		    d_datain = 16'hf000;
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		    d_datain = 16'h000f;       #10 i_datain = {`ADDC, `gr6, 1'b0, `gr1, 1'b0, `gr2};
		      #10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};      #10 i_datain = {`STORE, `gr6, 1'b0, `gr1, 4'b0010};
      #10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000}; 
		#10 i_datain = {`NOP, 11'b000_0000_0000};		      //#10 i_datain = {`HALT, 11'b000_0000_0000}; 
		
$display("Test ADDC");
$display(" Time/ps  pc      id_ir         reg_A reg_B reg_C d_we d_addr d_dataout  reg_C1  gr0   gr1   gr2   gr3   gr4   gr5   gr6   gr7");
   	#10 r_st = 1;
		#10 r_st = 0;
		#10 enable = 1;
		#10 start = 1;
		#10 start = 0;
			 i_datain = {`LOAD, `gr1, 1'b1, `gr0, 4'b0000};
		#10 i_datain = {`LOAD, `gr2, 1'b1, `gr0, 4'b0001};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
			 d_datain = 16'hf000;
		#10 i_datain = {`NOP, 11'b000_0000_0000};
			 d_datain = 16'h000f;  
		#10 i_datain = {`SUB, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`NOP, 11'b000_0000_0000};
		#10 i_datain = {`STORE, `gr3, 1'b0, `gr1, 4'b0010};
		#10 i_datain = {`HALT, 11'b000_0000_0000};*/
		
	end
      
endmodule

