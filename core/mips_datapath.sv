`define PC 32'h4000_000
module mips_datapath(mips_bfm.datapath_if data_if);

    logic [4:0] rd;
    logic [31:0] result, alu_result, 
                 operand_a, operand_b, 
                 sign_extended, rt;
    
    logic zero_flag, pc_src;

    assign rd = data_if.ctrl.reg_dst? data_if.inst.r_format.rd : data_if.inst.i_format.rt;
    assign result = data_if.ctrl.mem_to_reg? data_if.mem_rdata : alu_result; 
    mips_regfile regfile(
        .clk_i          (data_if.clk),
        .nrst_i         (data_if.nrst),
        .we_i           (data_if.ctrl.reg_write),
        .waddr_i        (rd),
        .wdata_i        (result),
        .raddr_i        ({data_if.inst.r_format.rs, data_if.inst.r_format.rt}),
        .rdata_o        ({operand_a, rt})
    );

    assign sign_extended = {{16{data_if.i_format.imm[15]}}, data_if.i_format.imm};
    assign operand_b = data_if.ctrl.alu_src? sign_extended: rt;
    mips_alu alu(
        .opcode_i       (data_if.alu_ctrl),
        .operand_a_i    (operand_a),
        .operand_b_i    (operand_b),
        .result_o       (alu_result),
        .zero_o         (zero_flag)
    );  

    logic [31:0] pcplus4, pc1, pc2,
                 jump_addr;
    assign pc_src = zero_flag & data_if.ctrl.branch;
    assign pcplus4 = data_if.pc + 4;
    assign pc1 = pc_src? 
                 ((sign_extended <<2) + pcplus4) : pcplus4; 
    assign jump_addr = {pcplus4[31:28], (data_if.inst.j_format.addr << 2)};
    assign pc2 = data_if.ctrl.jump? jump_addr : pc1;

    always_ff @(posedge data_if.clk, negedge data_if.nrst) begin
        if(!data_if.nrst) data_if.pc = `PC;
        else data_if.pc = pc2;
    end
    
    assign data_if.mem_daddr = alu_result;
    assign data_if.mem_wdata = rt;
endmodule
