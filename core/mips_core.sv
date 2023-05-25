module mips_core(
    input clk_i,
    input nrst_i
);

    mips_bfm mips_if(clk_i, nrst_i);
    
    mips_mem memory(
        .clk_i      (mips_if.clk),
        .nrst_i     (mips_if.nrst),
        .we_i       (mips_if.ctrl.mem_write),
        .waddr_i    (mips_if.mem_daddr),
        .wdata_i    (mips_if.mem_wdata),
        .raddr_i    ({mips_if.mem_daddr,mips_if.pc}),
        .rdata_o    ({mips_if.mem_rdata,mips_if.inst.r_format})
    );

    mips_control control(mips_if.control_if);

    mips_datapath datapath(mips_if.datapath_if);

endmodule
