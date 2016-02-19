
/* ================ Data Memory =============
     Name: Data Memory, store all instructions.
 Function: transfer instructions to operate.
 ============================================*/

`timescale 1ns / 1ps

// ********* Operations Define ************* //
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
// *********** Gr-index Define ************** //
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111

`define SIZE (2 ** 6)

// conbimation logic, without any clock.
module instruction_memory(
   input[15:0] i_addr,   // the address of the instruction.
	input r_st,           // reset signal.
   output[15:0] i_out    // the content of the instruction.
);

reg[15:0] memory[`SIZE - 1:0]; // set instruction memeory.

always@(*)
 begin
   if(r_st)
	   begin
        memory[0] <= {`LOAD, `gr1, 1'b1, `gr0, 4'b0000};			         memory[1] <= {`LOAD, `gr2, 1'b1, `gr0, 4'b0001};
        memory[2] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		  memory[3] <= {`LOAD, `gr4, 1'b1, `gr0, 4'b0010};
		  memory[4] <= {`LOAD, `gr5, 1'b1, `gr0, 4'b0011};
		  memory[5] <= {`SUB, `gr6, 1'b1, `gr4, 1'b0, `gr5};
		  memory[6] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		  memory[7] <= {`ADDC, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		  memory[8] <= {`NOP, 11'b000_0000_0000};  // reset cf.
		  memory[9] <= {`SUB, `gr6, 1'b1, `gr4, 1'b0, `gr5};
		  memory[10] <= {`SUBC, `gr6, 1'b1, `gr4, 1'b0, `gr5};
        memory[11] <= {`AND, `gr7, 1'b0, `gr1, 1'b0, `gr2};
        memory[12] <= {`OR, `gr7, 1'b0, `gr1, 1'b0, `gr2};
        memory[13] <= {`XOR, `gr7, 1'b0, `gr1, 1'b0, `gr2};		  
	     memory[14] <= {`SLL, `gr7, 1'b0, `gr2, 4'b0001};
		  memory[15] <= {`SRL, `gr7, 1'b0, `gr2, 4'b0001};
		  memory[16] <= {`SLA, `gr7, 1'b0, `gr2, 4'b0001};
		  memory[17] <= {`SRA, `gr7, 1'b0, `gr2, 4'b0001};
	     memory[18] <= {`STORE, `gr5, 1'b0, `gr0, 4'b1000};
		  memory[19] <= {`NOP, 11'b000_0000_0000};
		  memory[20] <= {`NOP, 11'b000_0000_0000};
		  memory[21] <= {`LOAD, `gr7, 1'b0, `gr0, 4'b1000};
		  memory[22] <= {`ADDI, `gr0, 4'b0000, 4'b1111};
		  memory[23] <= {`ADDC, `gr4, 1'b0, `gr3, 1'b0, `gr0};
		  memory[24] <= {`SUB, `gr3, 1'b0, `gr4, 1'b0, `gr2};
		  memory[25] <= {`SUBI, `gr3, 4'b0000, 4'b0000};
		  memory[26] <= {`CMP, `gr7, 1'b0, `gr3, 1'b0, `gr0};
		  memory[27] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
		  memory[28] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
        memory[31] <= {`HALT, 11'b000_0000_0000};
		end
 end
 
assign i_out = memory[i_addr];

endmodule
