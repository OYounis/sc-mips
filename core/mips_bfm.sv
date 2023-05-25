interface mips_bfm (
        input logic              clk,
        input logic              nrst
);

    mips_pkg::ctrl_t ctrl;
    
    //memory data port
    logic [31:0] mem_wdata;
    logic [31:0] mem_daddr;
    logic [31:0] mem_rdata;
    //memory instruction port
    logic [31:0] pc;
    mips_pkg::inst_t inst;

    modport datapath_if (
        input clk,
        input nrst,
        input ctrl,
        input inst,
        input mem_rdata,
        output mem_daddr,
        output mem_wdata,
        output pc
    );

    mips_pkg::opcode_e opcode;
    mips_pkg::funct_e  funct;
    assign opcode = inst.r_format.opcode; 
    assign funct  = inst.r_format.funct; 
    modport control_if (
        input opcode,
        input funct,
        output ctrl
    );
    
endinterface: mips_bfm
