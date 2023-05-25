package mips_pkg;
    typedef enum logic [2:0] {
        ALU_ADD = 3'b010, 
        ALU_SUB = 3'b110, 
        ALU_AND = 3'b000,
        ALU_OR  = 3'b001, 
        ALU_SLT = 3'b111
    } alu_op_e;
    
    typedef enum logic [5:0] {
        R_TYPE = 6'h00,
        ADDI = 6'h08,
        LW = 6'h23,
        SW = 6'h2b,
        BEQ = 6'h04,
        J = 6'h02
        //JAL = 6'h03
    } opcode_e;
    
    typedef enum logic [5:0]{
        //R_TYPE
        ADD = 6'h20,
        SUB = 6'h22,
        AND = 6'h24,
        OR  = 6'h25,
        SLT = 6'h2a
    } funct_e;

    typedef struct packed {
        opcode_e opcode;
        logic [4:0] rs;
        logic [4:0] rt;
        logic [4:0] rd; 
        logic [4:0] shamt;
        funct_e funct;
    } r_format_t;

    typedef struct packed {
        opcode_e opcode;
        logic [4:0] rs;
        logic [4:0] rt;
        logic [15:0] imm;
    } i_format_t;
    
    typedef struct packed {
        opcode_e opcode;
        logic [25:0] addr; 
    } j_format_t;

    typedef union packed {
        r_format_t r_format;
        i_format_t i_format;
        j_format_t j_format;
    } inst_t;

    typedef struct packed {
        logic reg_dst;
        logic mem_to_reg;
        logic reg_write;
        logic alu_src;
        alu_op_e alu_ctrl;
        logic branch;
        logic jump;
        logic mem_write;
    } ctrl_t;
endpackage
