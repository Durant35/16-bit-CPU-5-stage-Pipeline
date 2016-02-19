
/*=====================================================
    Name: core-module MIPS.
Function: Simple cpu contains only 27 operations.
	       Operation Set: NOP  HALT LOAD STORE LDIH ADD 
		                 ADDI ADDC SUB  SUBI  SUBC CMP
							  AND  OR   XOR  SLL   SRL  SLA
							  SRA  JUMP JMPR BZ    BNZ  BN 
							  BNN  BC   BNC.
==================================================== */

`timescale 1ns / 1ps 

// ***************** Operations Define ************ //
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
            /* ** No-used operations ****
`define NOP 5'd27
`define NOP 5'd28
`define NOP 5'd29
`define NOP 5'd30
`define NOP 5'd31
****************************************/

// ****************** CPU State Define *********** //
            // There are only two states of CPU:
`define IDLE 0
`define EXEC 1

// *********** MIPS Implementation *************** //
module mips(
   input clk, r_st,       // clock and reset signal.
	input start, enable,   // start stands for start button, enable stands for power enable.
   input[3:0] select_y,   // select_y and y no used tempoary.
	output[15:0] y,
                          // input from instruction memory and data memory.
	input[15:0] i_datain,  // the content of the instruction.
	input[15:0] d_datain,  // the data read from the data memory.
                          // output to instruction memory and data memory
	output[15:0] i_addr,   // the address of the instruction.
	output[15:0] d_addr,   // the address of the data(to store or to read).
	output[15:0] d_dataout,// the data to store.
   output d_we            // store enable for data memory.
);

// **************** CPU control ****************** //
reg state, next_state;    // keep CPU's state.

always @(posedge clk)
	begin
		if (r_st) state <= `IDLE;
		else state <= next_state;
	end
	
always @(*)
	begin
		case (state)
		 `IDLE :
         //	only when power enable and start button is push, CPU turns on.	 
			if ((enable == 1'b1) && (start == 1'b1)) next_state <= `EXEC;
			else next_state <= `IDLE;
		 `EXEC:
		   //	when power stops or HALT is operating, CPU turns off.	
			if ((enable == 1'b0) || (wb_ir[7:3] == `HALT)) next_state <= `IDLE;
			else next_state <= `EXEC;
		endcase
	end
	
// *************** Instruction Fetch ************* //
reg[15:0] id_ir;   // store the instruction in IF.
reg[15:0] pc;      // 16-bit program counter. 

always @(posedge clk)
	begin
		if (r_st)
		 begin
		  id_ir <= 16'b0000_0000_0000_0000;
		  pc <= 16'b0000_0000_0000_0000;
		 end	
		else if (state ==`EXEC)
			begin
         /* considering current operation is LOAD, and next operation needs to
            read the register it flushes, we need to hold the pc and set id_ir
	         to no-sense, then operate the next operation later.
         */if((id_ir[15:11] == `LOAD) 
			    &&( ( (
				       (i_datain[15:11] == `STORE)
				     ||(i_datain[15:11] == `LDIH)||(i_datain[15:11] == `ADDI)||(i_datain[15:11] == `SUBI) 
				     ||(i_datain[15:11] == `JMPR)
				     ||(i_datain[15:11] == `BZ)||(i_datain[15:11] == `BNZ) 
				     ||(i_datain[15:11] == `BC)||(i_datain[15:11] == `BNC) 
				     ||(i_datain[15:11] == `BN)||(i_datain[15:11] == `BNN) )
				   &&(i_datain[10:8] == id_ir[10:8]) )    
					       // the next operation needs to read the flushed register as operand1. 
				   ||( (
				       (i_datain[15:11] == `LOAD)||(i_datain[15:11] == `STORE)
				     ||(i_datain[15:11] == `ADD) ||(i_datain[15:11] == `ADDC)
					  ||(i_datain[15:11] == `SUB)||(i_datain[15:11] == `SUBC) 
				     ||(i_datain[15:11] == `CMP)
				     ||(i_datain[15:11] == `AND)||(i_datain[15:11] == `OR)||(i_datain[15:11] == `XOR)
				     ||(i_datain[15:11] == `SLL)||(i_datain[15:11] == `SRL) 
				     ||(i_datain[15:11] == `SLA)||(i_datain[15:11] == `SRA) )
				   &&(i_datain[6:4] === id_ir[10:8]) )    
					      // the next operation needs to read the flushed register as operand2. 
				   ||( (
					    (i_datain[15:11] == `ADD)||(i_datain[15:11] == `ADDC)
					  ||(i_datain[15:11] == `SUB)||(i_datain[15:11] == `SUBC) 
				     ||(i_datain[15:11] == `CMP)
				     ||(i_datain[15:11] == `AND)||(i_datain[15:11] == `OR)||(i_datain[15:11] == `XOR) )
				   &&(i_datain[2:0] == id_ir[10:8]) )
					     // the next operation needs to read the flushed register as operand3. 
				   ) )
			  id_ir[15:11] <= 5'b1111_1;  
			           // make id_ir useless and hold pc, the lowest 11bits hold its previous value. 
		   else
			 begin
			  // assignment for id_ir.
			  id_ir <= i_datain;
				
		     /* assignment for pc.
              all control operations are connected to control pc.
			  */if( ((mem_ir[7:3] == `BZ)  && (zf == 1'b1))
               ||((mem_ir[7:3] == `BNZ) && (zf == 1'b0))			
				   ||((mem_ir[7:3] == `BN)  && (nf == 1'b1))
				   ||((mem_ir[7:3] == `BNN) && (nf == 1'b0))
				   ||((mem_ir[7:3] == `BC)  && (cf == 1'b1))
				   ||((mem_ir[7:3] == `BNC) && (cf == 1'b0))
				   ||( mem_ir[7:3] == `JUMP)
				   ||( mem_ir[7:3] == `JMPR) )
					  pc <= reg_C;     // pc jump to reg_C.
				 else
					  pc <= pc + 1;	 // otherwise, pc increases by one.
		  end
	  end
  end

assign i_addr = pc;  
// assignment for i_addr as input to the instruction memory.
	
// ***************** Instruction Decode **************** //
reg[15:0] gr[7:0];        // 8 16-bit general registers
reg[7:0] ex_ir;          // store the instruction in EX.
reg[15:0] reg_A, reg_B;   // first and second operand of ALU.
reg[15:0] smdr;           // store data for writing directly.

always@(posedge clk)
   begin
     if(r_st)
	   begin
	    ex_ir <= 8'b0000_0000;
		 reg_A <= 16'b0000_0000_0000_0000;
		 reg_B <= 16'b0000_0000_0000_0000;
		 smdr  <= 16'b0000_0000_0000_0000;
	   end
	  else if (state == `EXEC)
	   begin
	 // assignment for ex_ir. 
		 ex_ir <= id_ir[15:8];
		 
    // -------------------------- assignment for smdr  ------------------------------ //
	 /* operations before do flush the general register and 
		 current STORE needs to read this register, both are operand1. 
	 */ 
	 // consider current operation is STORE && having LOAD operation before.
	    if((id_ir[15:11] == `STORE) 
	      &&( (mem_ir[7:3] == `LOAD)&&(mem_ir[2:0] == id_ir[10:8]) ))
		   smdr <= d_datain;
  // combine having other operations except LOAD before due to the same assigned to reg_C1.
  else if((id_ir[15:11] === `STORE)
	      &&( ((wb_ir[7:3] == `LOAD)||(wb_ir[7:3] == `LDIH)
		      ||(wb_ir[7:3] == `ADD) ||(wb_ir[7:3] == `ADDI)||(wb_ir[7:3] == `ADDC)
		      ||(wb_ir[7:3] == `SUB) ||(wb_ir[7:3] == `SUBI)||(wb_ir[7:3] == `SUBC)
		      ||(wb_ir[7:3] == `SLL) ||(wb_ir[7:3] == `SLA) ||(wb_ir[7:3] == `SRL)||(wb_ir[7:3] == `SRA)
		      ||(wb_ir[7:3] == `AND) ||(wb_ir[7:3] == `OR)  ||(wb_ir[7:3] == `XOR) )
		     &&(wb_ir[2:0] == id_ir[10:8]) ))
		   smdr <= reg_C1;
  /* consider current operation is STORE && having other operations do flush the register before.
     the register that other operations do flush is always gr[operand1]. 
  */
  else if((id_ir[15:11] == `STORE)
	      &&( ((ex_ir[7:3] == `LDIH)
		      ||(ex_ir[7:3] == `ADD) ||(ex_ir[7:3] == `ADDI)||(ex_ir[7:3] == `ADDC)
		      ||(ex_ir[7:3] == `SUB) ||(ex_ir[7:3] == `SUBI)||(ex_ir[7:3] == `SUBC)
		      ||(ex_ir[7:3] == `SLL) ||(ex_ir[7:3] == `SLA) ||(ex_ir[7:3] == `SRL)||(ex_ir[7:3] == `SRA)
		      ||(ex_ir[7:3] == `AND) ||(ex_ir[7:3] == `OR)  ||(ex_ir[7:3] == `XOR) )
		     &&(ex_ir[2:0] == id_ir[10:8]) ))
		   smdr <= ALUo;
  else if((id_ir[15:11] == `STORE)
	      &&( ((mem_ir[7:3] == `LDIH)
		      ||(mem_ir[7:3] == `ADD) ||(mem_ir[7:3] == `ADDI)||(mem_ir[7:3] == `ADDC)
		      ||(mem_ir[7:3] == `SUB) ||(mem_ir[7:3] == `SUBI)||(mem_ir[7:3] == `SUBC)
		      ||(mem_ir[7:3] == `SLL) ||(mem_ir[7:3] == `SLA) ||(mem_ir[7:3] == `SRL)||(mem_ir[7:3] == `SRA)
		      ||(mem_ir[7:3] == `AND) ||(mem_ir[7:3] == `OR)  ||(mem_ir[7:3] == `XOR) )
		     &&(mem_ir[2:0] == id_ir[10:8])))
		   smdr <= reg_C;
  // operations before do not flush the general registers.  
  else if(id_ir[15:11] == `STORE)
			smdr <= gr[id_ir[10:8]];		
  // otherwise, hold his previous value.
	
	
   // ---------------------------- assignment for reg_A  ------------------------------ // 
   /* when operation is ADDI、SUBI、LDIH and all control operations, except JUMP, reg_A choose gr[r1];
      otherwise, except NOP and HALT, choose gr[r2] */
       /* operations before do flush the general registers and 
		    current operation needs to read those registers 
		 */	
        // consider having LOAD operation before.		 
        if( (mem_ir[7:3] == `LOAD)
		   &&( (( 
			    (id_ir[15:11] == `LDIH)||(id_ir[15:11] == `ADDI)||(id_ir[15:11] == `SUBI) 
		     ||(id_ir[15:11] == `JMPR)
		     ||(id_ir[15:11] == `BZ)||(id_ir[15:11] == `BNZ) 
		     ||(id_ir[15:11] == `BC)||(id_ir[15:11] == `BNC) 
		     ||(id_ir[15:11] == `BN)||(id_ir[15:11] == `BNN) )
		    &&(id_ir[10:8] == mem_ir[2:0]) ) 
			     // current operation's gr[operand1] needs to read the flushed register as reg_A. 
		  ||(( (id_ir[15:11] == `LOAD)||(id_ir[15:11] == `STORE)
		     ||(id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		     ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		     ||(id_ir[15:11] == `CMP)
		     ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR)
		     ||(id_ir[15:11] == `SLL)||(id_ir[15:11] == `SRL) 
		     ||(id_ir[15:11] == `SLA)||(id_ir[15:11] == `SRA) )
		    &&(id_ir[6:4] == mem_ir[2:0]) )) )
			    // current operation's gr[operand2] needs to read the flushed register as reg_A.
		   reg_A <= d_datain;  // d_datain as reg_A.
  // combine having other operations except LOAD before due to the same assigned to reg_C1.
  else if(( (wb_ir[7:3] == `LOAD)
		   &&( (( 
			     (id_ir[15:11] == `LDIH)||(id_ir[15:11] == `ADDI)||(id_ir[15:11] == `SUBI) 
		      ||(id_ir[15:11] == `JMPR)
		      ||(id_ir[15:11] == `BZ)||(id_ir[15:11] == `BNZ) 
		      ||(id_ir[15:11] == `BC)||(id_ir[15:11] == `BNC) 
		      ||(id_ir[15:11] == `BN)||(id_ir[15:11] == `BNN) )
		     &&(id_ir[10:8] == wb_ir[2:0]) )
			    // current operation's gr[operand1] needs to read the flushed register as reg_A.
		     ||(( 
			     (id_ir[15:11] == `LOAD)||(id_ir[15:11] == `STORE)
		      ||(id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		      ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		      ||(id_ir[15:11] == `CMP)
		      ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR)
		      ||(id_ir[15:11] == `SLL)||(id_ir[15:11] == `SRL) 
		      ||(id_ir[15:11] == `SLA)||(id_ir[15:11] == `SRA) )
		     &&(id_ir[6:4] == wb_ir[2:0]) )) )
			   // current operation's gr[operand2] needs to read the flushed register as reg_A.
		  ||(( (wb_ir[7:3] == `LDIH)
		     ||(wb_ir[7:3] == `ADD) ||(wb_ir[7:3] == `ADDI)||(wb_ir[7:3] == `ADDC)
		     ||(wb_ir[7:3] == `SUB) ||(wb_ir[7:3] == `SUBI)||(wb_ir[7:3] == `SUBC)
		     ||(wb_ir[7:3] == `SLL) ||(wb_ir[7:3] == `SLA) ||(wb_ir[7:3] == `SRL)||(wb_ir[7:3] == `SRA)
		     ||(wb_ir[7:3] == `AND) ||(wb_ir[7:3] == `OR)  ||(wb_ir[7:3] == `XOR) )
		    &&(( ((id_ir[15:11] == `LDIH)||(id_ir[15:11] == `ADDI)||(id_ir[15:11] == `SUBI) 
		        ||(id_ir[15:11] == `JMPR)
		        ||(id_ir[15:11] == `BZ)||(id_ir[15:11] == `BNZ) 
		        ||(id_ir[15:11] == `BC)||(id_ir[15:11] == `BNC) 
		        ||(id_ir[15:11] == `BN)||(id_ir[15:11] == `BNN) )
		       &&(wb_ir[2:0] == id_ir[10:8]) )
				// current operation's gr[operand1] needs to read the flushed register as reg_A.
		      ||(((id_ir[15:11] == `LOAD)||(id_ir[15:11] == `STORE)
		        ||(id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		        ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		        ||(id_ir[15:11] == `CMP)
		        ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR)
		        ||(id_ir[15:11] == `SLL)||(id_ir[15:11] == `SRL) 
		        ||(id_ir[15:11] == `SLA)||(id_ir[15:11] == `SRA) )
		        &&(wb_ir[2:0] == id_ir[6:4])) )) )
			   // current operation's gr[operand2] needs to read the flushed register as reg_A.
		  reg_A <= reg_C1; // reg_C1 as reg_A.
  /* consider having other operations do flush the register before.
     the register that other operations do flush is always gr[operand1]. 
  */	   
  else if(( (ex_ir[7:3] == `LDIH)
		    ||(ex_ir[7:3] == `ADD) ||(ex_ir[7:3] == `ADDI)||(ex_ir[7:3] === `ADDC)
		    ||(ex_ir[7:3] == `SUB) ||(ex_ir[7:3] == `SUBI)||(ex_ir[7:3] === `SUBC)
		    ||(ex_ir[7:3] == `SLL) ||(ex_ir[7:3] == `SLA) ||(ex_ir[7:3] === `SRL)||(ex_ir[7:3] === `SRA)
		    ||(ex_ir[7:3] == `AND) ||(ex_ir[7:3] == `OR)  ||(ex_ir[7:3] === `XOR) )
		   &&( (( (id_ir[15:11] == `LDIH)||(id_ir[15:11] == `ADDI)||(id_ir[15:11] === `SUBI) 
		        ||(id_ir[15:11] == `JMPR)
		        ||(id_ir[15:11] == `BZ)||(id_ir[15:11] == `BNZ) 
		        ||(id_ir[15:11] == `BC)||(id_ir[15:11] == `BNC) 
		        ||(id_ir[15:11] == `BN)||(id_ir[15:11] == `BNN) )
		       &&(ex_ir[2:0] == id_ir[10:8]) )
				 // current operation's gr[operand1] needs to read the flushed register as reg_A.
		     ||(( (id_ir[15:11] == `LOAD)||(id_ir[15:11] == `STORE)
		        ||(id_ir[15:11] === `ADD)||(id_ir[15:11] === `ADDC)
		        ||(id_ir[15:11] === `SUB)||(id_ir[15:11] === `SUBC) 
		        ||(id_ir[15:11] === `CMP)
		        ||(id_ir[15:11] === `AND)||(id_ir[15:11] === `OR)||(id_ir[15:11] === `XOR)
		        ||(id_ir[15:11] === `SLL)||(id_ir[15:11] === `SRL) 
		        ||(id_ir[15:11] === `SLA)||(id_ir[15:11] === `SRA) )
		       &&(ex_ir[2:0] === id_ir[6:4])) ) )
				 // current operation's gr[operand2] needs to read the flushed register as reg_A.
		   reg_A <= ALUo; // reg_A chooses ALUo.
  else if( ( (mem_ir[7:3] === `LDIH)
		     ||(mem_ir[7:3] === `ADD) ||(mem_ir[7:3] === `ADDI)||(mem_ir[7:3] === `ADDC)
		     ||(mem_ir[7:3] === `SUB) ||(mem_ir[7:3] === `SUBI)||(mem_ir[7:3] === `SUBC)
		     ||(mem_ir[7:3] === `SLL) ||(mem_ir[7:3] === `SLA) ||(mem_ir[7:3] === `SRL)||(mem_ir[7:3] === `SRA)
		     ||(mem_ir[7:3] === `AND) ||(mem_ir[7:3] === `OR)  ||(mem_ir[7:3] === `XOR) )
		    &&( (( (id_ir[15:11] === `LDIH)||(id_ir[15:11] === `ADDI)||(id_ir[15:11] === `SUBI) 
		         ||(id_ir[15:11] === `JMPR)
		         ||(id_ir[15:11] === `BZ)||(id_ir[15:11] === `BNZ) 
		         ||(id_ir[15:11] === `BC)||(id_ir[15:11] === `BNC) 
		         ||(id_ir[15:11] === `BN)||(id_ir[15:11] === `BNN) )
		        &&(mem_ir[2:0] === id_ir[10:8]) ) 
               // current operation's gr[operand1] needs to read the flushed register as reg_A.				  
		      ||(( (id_ir[15:11] === `LOAD)||(id_ir[15:11] === `STORE)
		         ||(id_ir[15:11] === `ADD)||(id_ir[15:11] === `ADDC)
		         ||(id_ir[15:11] === `SUB)||(id_ir[15:11] === `SUBC) 
		         ||(id_ir[15:11] === `CMP)
		         ||(id_ir[15:11] === `AND)||(id_ir[15:11] === `OR)||(id_ir[15:11] === `XOR)
		         ||(id_ir[15:11] === `SLL)||(id_ir[15:11] === `SRL) 
		         ||(id_ir[15:11] === `SLA)||(id_ir[15:11] === `SRA) )
		        &&(mem_ir[2:0] === id_ir[6:4])) ) )
				  // current operation's gr[operand2] needs to read the flushed register as reg_A.
		   reg_A <= reg_C; // reg_A chooses reg_C.
  // operations before do not flush the general registers 
  else if( (id_ir[15:11] === `BZ)||(id_ir[15:11] === `BNZ)||(id_ir[15:11] === `BN)
		    ||(id_ir[15:11] === `BNN) ||(id_ir[15:11] === `BC) ||(id_ir[15:11] === `BNC)
		    ||(id_ir[15:11] === `JMPR)||(id_ir[15:11] === `ADDI)
		    ||(id_ir[15:11] === `SUBI)||(id_ir[15:11] === `LDIH) )
		   reg_A <= gr[id_ir[10:8]]; // reg_A chooses gr[operand1].
  else if( (id_ir[15:11] === `LOAD)||(id_ir[15:11] === `STORE)
          ||(id_ir[15:11] === `ADD) ||(id_ir[15:11] === `ADDC)||(id_ir[15:11] === `SUB)||(id_ir[15:11] === `SUBC)
		    ||(id_ir[15:11] === `CMP) ||(id_ir[15:11] === `AND) ||(id_ir[15:11] === `OR) ||(id_ir[15:11] === `XOR)
		    ||(id_ir[15:11] === `SLL) ||(id_ir[15:11] === `SRL) ||(id_ir[15:11] === `SLA)||(id_ir[15:11] === `SRA))
			reg_A <= gr[id_ir[6:4]];  // reg_A chooses gr[operand2].		   
  // otherwise, reg_A holds previous value.		
		
    //--------------------------- assignment for reg_B ----------------------------------- //
      /* when operation is LOAD、STORE and four shift operations, reg_B choose {12'b0000_0000_0000, val3},
         when is ADDI、SUBI and all control operations, choose {8'b0000_0000, val2, val3},
		   when is LDIH, choose {val2, val3, 8'b0000_0000},
		   otherwise gr[r3] except NOP and HALT.
		*/
		/* operations before do flush the general registers 
		   and current operation needs to read those registers
		*/
      // consider having LOAD operation before.		
       if( (mem_ir[7:3] == `LOAD)
		 &&( ( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		     ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		     ||(id_ir[15:11] == `CMP)
		     ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) )
		    &&(id_ir[2:0] == mem_ir[2:0]) ))
			  // current operation's gr[operand3] needs to read the flushed register as reg_B.
		   reg_B <= d_datain; // reg_B chooses d_datain.
  // combine having other operations except LOAD before due to the same assigned to reg_C1.
  else if( ((wb_ir[7:3] == `LOAD)
		    &&(( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		       ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		       ||(id_ir[15:11] == `CMP)
		       ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) )
		      &&(id_ir[2:0] == wb_ir[2:0])) )
				// current operation's gr[operand3] needs to read the flushed register as reg_B.
		 ||(( (wb_ir[7:3] == `LDIH)
		    ||(wb_ir[7:3] == `ADD) ||(wb_ir[7:3] == `ADDI)||(wb_ir[7:3] == `ADDC)
		    ||(wb_ir[7:3] == `SUB) ||(wb_ir[7:3] == `SUBI)||(wb_ir[7:3] == `SUBC)
		    ||(wb_ir[7:3] == `SLL) ||(wb_ir[7:3] == `SLA) ||(wb_ir[7:3] == `SRL)||(wb_ir[7:3] == `SRA)
		    ||(wb_ir[7:3] == `AND) ||(wb_ir[7:3] == `OR)  ||(wb_ir[7:3] == `XOR) )
		   &&(( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		      ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		      ||(id_ir[15:11] == `CMP)
		      ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) )
		   &&(wb_ir[2:0] == id_ir[2:0])) ) )
			  // current operation's gr[operand3] needs to read the flushed register as reg_B.
		   reg_B <= reg_C1; // reg_B chooses reg_C1.
  /* consider having other operations do flush the register before.
     the register that other operations do flush is always gr[operand1]. 
  */	 	   
  else if( ( (ex_ir[7:3] == `LDIH)
		     ||(ex_ir[7:3] == `ADD) ||(ex_ir[7:3] == `ADDI)||(ex_ir[7:3] == `ADDC)
		     ||(ex_ir[7:3] == `SUB) ||(ex_ir[7:3] == `SUBI)||(ex_ir[7:3] == `SUBC)
		     ||(ex_ir[7:3] == `SLL) ||(ex_ir[7:3] == `SLA) ||(ex_ir[7:3] == `SRL)||(ex_ir[7:3] == `SRA)
		     ||(ex_ir[7:3] == `AND) ||(ex_ir[7:3] == `OR)  ||(ex_ir[7:3] == `XOR) )
		      &&(( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		         ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		         ||(id_ir[15:11] == `CMP)
		         ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) )
		       &&(ex_ir[2:0] == id_ir[2:0]) ) )
				   // current operation's gr[operand3] needs to read the flushed register as reg_B.
		      reg_B <= ALUo; // reg_B chooses ALUo.
  else if( ( (mem_ir[7:3] == `LDIH)
		     ||(mem_ir[7:3] == `ADD) ||(mem_ir[7:3] == `ADDI)||(mem_ir[7:3] == `ADDC)
		     ||(mem_ir[7:3] == `SUB) ||(mem_ir[7:3] == `SUBI)||(mem_ir[7:3] == `SUBC)
		     ||(mem_ir[7:3] == `SLL) ||(mem_ir[7:3] == `SLA) ||(mem_ir[7:3] == `SRL)||(mem_ir[7:3] == `SRA)
		     ||(mem_ir[7:3] == `AND) ||(mem_ir[7:3] == `OR)  ||(mem_ir[7:3] == `XOR))
		     &&(( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		        ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC) 
		        ||(id_ir[15:11] == `CMP)
		        ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) )
		       &&(mem_ir[2:0] == id_ir[2:0]) ) )
				   // current operation's gr[operand3] needs to read the flushed register as reg_B.
		     reg_B <= reg_C;                          // reg_B chooses reg_C.
  // operations before do not flush the general registers. 		
  else if( (id_ir[15:11] == `ADD)||(id_ir[15:11] == `ADDC)
		   ||(id_ir[15:11] == `SUB)||(id_ir[15:11] == `SUBC)
		   ||(id_ir[15:11] == `CMP)
		   ||(id_ir[15:11] == `AND)||(id_ir[15:11] == `OR)||(id_ir[15:11] == `XOR) ) 
			 reg_B <= gr[id_ir[2:0]];                  // reg_B chooses gr[operand3].
  // reg_B does not need to access general register.
  else if( (id_ir[15:11] == `LOAD)||(id_ir[15:11] == `STORE) 
		   ||(id_ir[15:11] == `SLL) ||(id_ir[15:11] == `SLA) 
		   ||(id_ir[15:11] == `SRL) ||(id_ir[15:11] == `SRA) )
		   reg_B <= {12'b0000_0000_0000, id_ir[3:0]}; // reg_B choose {12'b0000_0000_0000, val3}.
  else if( (id_ir[15:11] == `ADDI)||(id_ir[15:11] == `SUBI)
	      ||(id_ir[15:11] == `JUMP)||(id_ir[15:11] == `JMPR)
		   ||(id_ir[15:11] == `BZ)  ||(id_ir[15:11] == `BNZ)
		   ||(id_ir[15:11] == `BN)  ||(id_ir[15:11] == `BNN)
		   ||(id_ir[15:11] == `BC)  ||(id_ir[15:11] == `BNC) )
			reg_B <= {8'b0000_0000, id_ir[7:0]};       // reg_B choose {8'b0000_0000, val2, val3}.
  else if(id_ir[15:11] == `LDIH)
			reg_B <= {id_ir[7:0], 8'b0000_0000};       // reg_B choose {val2, val3, 8'b0000_0000}.			 
  // otherwise, hold his previous value.	
	 
	  end
  end		
			
// ************************* Execute ************************* //
reg[15:0] reg_C;     // reg_C used to store the result of ALU.
reg[15:0] smdr1;     // smdr1 stores data for direct-saving.
reg[7:0] mem_ir;    // store the instruction in MEM.
                     // three flags to remark zero, negative and carry in respectively.
reg zf, nf, cf; 
                     // ALUo and carry_in are ALU's output.
wire[15:0] ALUo; 
wire carry_in; 

// ALU module: operate reg_A, reg_B and get the result ALUo, carry_in. 
   alu u1(
	      .r_st(r_st),
	      .ALUCode(ex_ir[7:3]),
	      .A(reg_A),   
	      .B(reg_B),
	      .cf_in(cf),
	      .cf_out(carry_in),
	      .ALU_out(ALUo)
   );
		
always@(posedge clk)
  begin
     if(r_st)
		  begin
		       zf  <= 0;
			    nf  <= 0;
			    cf  <= 0;
			 mem_ir <= 8'b0000_0000;
			 reg_C  <= 16'b0000_0000_0000_0000;
		  end
	  else if (state == `EXEC)
		 begin
			// assignment for mem_ir.
				mem_ir <= ex_ir;
				
			// assignment for reg_C.
				reg_C <= ALUo;
				
			// assignment for three flags.
                             // carry in flag.
			   cf <= carry_in;
			                    // zero flag.
			   if(ALUo == 16'b0000_0000_0000_0000) zf <= 1;
				else zf <= 0;
		                       // negative flag. 
			   if(ALUo[15] == 1) nf <= 1;
				else nf <= 0;
					 
		   // assignment for smdr1.
			   if(ex_ir[7:3] == `STORE) smdr1 <= smdr;
				// otherwise, hold its previous value.
	  end
  end
           
assign d_we = (mem_ir[7:3] == `STORE)? (1'b1) : (1'b0);
// assignment for data write enable as output. 
assign d_dataout = smdr1;
assign d_addr = reg_C;
// assignment for data to write and data's address as output.  
			
// ************************* Memory ************************* //
reg[15:0] reg_C1;       // store the result of ALU or data, read from data memory.
reg[7:0] wb_ir;        // store the instruction in WB.

always@(posedge clk)
  begin
    if(r_st)
	   begin
	      wb_ir  <= 8'b0000_0000;
		   reg_C1 <= 16'b0000_0000_0000_0000;
	   end
    else if (state == `EXEC)
	   begin
	  // assignment for wb_ir.
		  wb_ir <= mem_ir;
		
	  // assignment for reg_C1. 		
	     if (mem_ir[7:3] == `LOAD) reg_C1 <= d_datain;
		  else if( (mem_ir[7:3] == `LDIH)
		         ||(mem_ir[7:3] == `ADD) ||(mem_ir[7:3] == `ADDI)||(mem_ir[7:3] == `ADDC)
		         ||(mem_ir[7:3] == `SUB) ||(mem_ir[7:3] == `SUBI)||(mem_ir[7:3] == `SUBC)
		         ||(mem_ir[7:3] == `SLL) ||(mem_ir[7:3] == `SLA) ||(mem_ir[7:3] == `SRL)||(mem_ir[7:3] == `SRA)
		         ||(mem_ir[7:3] == `AND) ||(mem_ir[7:3] == `OR)  ||(mem_ir[7:3] == `XOR) ) 
		        reg_C1 <= reg_C;
		  // otherwise, keep its previous value.
	   end
  end
		
// ************************* Write Back ************************* //
always@(posedge clk)
  begin
   if (state == `EXEC)
	 begin
   /* some operations: LOAD、LDIH、ADD、ADDI、ADDC、SUB、SUBI、SUBC、AND、OR、XOR、SLL、SRL、SLA、SRA
      need write back to general registers.
   */if ((wb_ir[7:3] == `LOAD)||(wb_ir[7:3] == `LDIH)
		 ||(wb_ir[7:3] == `ADD) ||(wb_ir[7:3] == `ADDI)||(wb_ir[7:3] == `ADDC)
		 ||(wb_ir[7:3] == `SUB) ||(wb_ir[7:3] == `SUBI)||(wb_ir[7:3] == `SUBC)
		 ||(wb_ir[7:3] == `SLL) ||(wb_ir[7:3] == `SLA) ||(wb_ir[7:3] == `SRL)||(wb_ir[7:3] == `SRA)
		 ||(wb_ir[7:3] == `AND) ||(wb_ir[7:3] == `OR)  ||(wb_ir[7:3] == `XOR))
		    gr[wb_ir[2:0]] <= reg_C1;
     // otherwise, hold his previous value.			
	 end
  end
	
endmodule
