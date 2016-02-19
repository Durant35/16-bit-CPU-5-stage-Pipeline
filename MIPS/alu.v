/*==================================================
       Name: ALU module
	Function: Arithmetic & Logical operations.
====================================================*/
`timescale 1ns / 1ps

// ****************************** Operations Define **************************** //
// There are 26 operations in total.
// Data transfer & Arithmetic operations:
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
`define SUBC 5'd9
`define CMP 5'd10
// Logical & Shift operations:
`define AND 5'd11
`define OR 5'd12
`define XOR 5'd13
`define SLL 5'd14
`define SRL 5'd15
`define SLA 5'd16
`define SRA 5'd17
// Control operations:
`define JUMP 5'd18
`define JMPR 5'd19
`define BZ 5'd20
`define BNZ 5'd21
`define BN 5'd22
`define BNN 5'd23
`define BC 5'd24
`define BNC 5'd25
/*** No-used operations ****
`define NOP 5'd27
`define NOP 5'd28
`define NOP 5'd29
`define NOP 5'd30
`define NOP 5'd31
****************************/

// alu module implemented as combination logic, so without clk
module alu (  
   input r_st,
	input[4:0]	ALUCode,				// Operation select
	input [15:0] A, B,
	input cf_in,
	output cf_out,
	output [15:0] ALU_out
);

// shift operation: ">>>" will perform an arithmetic right shift, but the operand must be reg signed
wire signed[15:0] reg_A;  
assign reg_A = A;

reg[15:0] Result;
reg cf;


/* cf在加法时作为进位标志, 减法时作为借位标志. */
always @(*)
  begin
    if(r_st) {cf, Result} <= 17'b0;
    else 
	   case(ALUCode)
`LOAD, `STORE, 
  `LDIH, `ADD,
 `ADDI, `JMPR,
	 `BZ, `BNZ,
	 `BC, `BNC,
	 `BN, `BNN  : {cf, Result} <= A + B; // 加法
	      `ADDC : {cf, Result} <= (A + B) + cf_in; // 带有进位cf_in的加法 
	      `SUB,
         `SUBI : {cf, Result} <= A - B; // 减法
			`SUBC : {cf, Result} <= (A - B) - cf_in; // 带有借位cf_in的减法 
          `AND : {cf, Result} <= A & B; // 与操作
          `XOR : {cf, Result} <= A ^ B; // 异或操作
           `OR : {cf, Result} <= A | B; // 或操作
          `SLL : {cf, Result} <= A << B; // 逻辑左移
	       `SLA : {cf, Result} <= reg_A <<< B; // 算术左移
          `SRL : {cf, Result} <= A >> B; // 逻辑右移
          `SRA : {cf, Result} <= reg_A >>> B; // 算术右移
		    `CMP : {cf, Result} <= A - B; // 比较A、B的大小关系 
         `JUMP : {cf, Result} <= B; // 传输B(用于JUMP操作,指示指令指针跳转地址)
		 // default : {cf, Result} <= 17'bx;
      endcase
  end
				 
assign ALU_out = Result; // pass result as output 
assign cf_out = cf;

endmodule
