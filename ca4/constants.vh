// op code
parameter R_type = 7'b0110011;
parameter I_type_alu = 7'b0010011;
parameter I_type_load = 7'b0000011;
parameter I_type_jump = 7'b1100111;
parameter S_type = 7'b0100011;
parameter B_type = 7'b1100011;
parameter J_type = 7'b1101111;
parameter U_type = 7'b0110111;

// func3 R type code
parameter func3_R_type_add_sub = 3'b000;
parameter func3_R_type_sll = 3'b001;
parameter func3_R_type_slt = 3'b010;
parameter func3_R_type_sltu = 3'b011;
parameter func3_R_type_xor = 3'b100;
parameter func3_R_type_or = 3'b110;
parameter func3_R_type_and = 3'b111;

// func3 I type code
parameter func3_I_type_lw = 3'b010;
parameter func3_I_type_addi = 3'b000;
parameter func3_I_type_slti = 3'b010;
parameter func3_I_type_sltiu = 3'b011;
parameter func3_I_type_xori = 3'b100;
parameter func3_I_type_ori = 3'b110;
parameter func3_I_type_andi = 3'b111;
parameter func3_I_type_jalr = 3'b000;

// func3 S type code
parameter func3_S_type_sb = 3'b000;
parameter func3_S_type_sh = 3'b001;
parameter func3_S_type_sw = 3'b010;

// func3 B type code
parameter func3_B_type_beq = 3'b000;
parameter func3_B_type_bne = 3'b001;
parameter func3_B_type_blt = 3'b100;
parameter func3_B_type_bge = 3'b101;

// func3 J type code
parameter func3_J_type_jal = 3'b000;

// func3 U type code
parameter func3_U_type_lui = 3'b011;
parameter func3_U_type_auipc = 3'b100;

// func7 R type code
parameter func7_R_type_default = 7'b0000000;
parameter func7_R_type_sub = 7'b0100000;

// immediate extend operation
parameter imm_I_type = 3'b000;
parameter imm_S_type = 3'b001;
parameter imm_B_type = 3'b010;
parameter imm_J_type = 3'b011;
parameter imm_U_type = 3'b100;
parameter imm_default = 3'b000;

// ALU operation
parameter op_add  = 3'b000;
parameter op_sub  = 3'b001;
parameter op_and  = 3'b010;
parameter op_or   = 3'b011;
parameter op_slt  = 3'b100;
parameter op_sltu = 3'b101;
parameter op_xor  = 3'b110;
parameter op_default = 3'b000;

// Jump
parameter J_disable = 2'b00;
parameter JumpJalr = 2'b01;
parameter JumpJal = 2'b10;

// B type code for logic
parameter B_disable = 3'b000;
parameter B_type_beq = 3'b001;
parameter B_type_bne = 3'b100;
parameter B_type_blt = 3'b101;
parameter B_type_bge = 3'b110;

// ResultSrc
parameter Result_ALU = 2'b00;
parameter Result_mem = 2'b01;
parameter Result_PC = 2'b10;
parameter Result_imm = 2'b11;

// ALU Src B select
parameter ALU_src_reg = 1'b0;
parameter ALU_src_imm = 1'b1;

// PCSrc
parameter PC_4 = 2'b00;
parameter PC_reg_imm = 2'b01;
parameter PC_imm = 2'b10;

// Forward select
parameter Forward_none = 2'b00;
parameter Forward_ResultW = 2'b01;
parameter Forward_ALUM = 2'b10;
parameter Forward_ImmM = 2'b11;