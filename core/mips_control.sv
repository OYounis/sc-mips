module mips_control (mips_bfm.control_if ctrl_if);
    always_comb begin
        unique case (ctrl_if.opcode)
            mips_pkg::R_TYPE : begin
                ctrl_if.ctrl.reg_write  = 1;
                ctrl_if.ctrl.reg_dst    = 1;
                ctrl_if.ctrl.alu_src    = 0;
                ctrl_if.ctrl.branch     = 0;
                ctrl_if.ctrl.mem_write  = 0;
                ctrl_if.ctrl.mem_to_reg = 0;
                case (ctrl_if.funct)
                    mips_pkg::ADD : ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_ADD;
                    mips_pkg::SUB : ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_SUB;
                    mips_pkg::AND : ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_AND;
                    mips_pkg::OR  : ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_OR; 
                    mips_pkg::SLT : ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_SLT;  
                endcase
            end mips_pkg::LW  : begin
                ctrl_if.ctrl.reg_write  = 1;
                ctrl_if.ctrl.reg_dst    = 0;
                ctrl_if.ctrl.alu_src    = 1;
                ctrl_if.ctrl.branch     = 0;
                ctrl_if.ctrl.mem_write  = 0;
                ctrl_if.ctrl.mem_to_reg = 1;
                ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_ADD;                
            end mips_pkg::SW  : begin
                ctrl_if.ctrl.reg_write  = 0;
                ctrl_if.ctrl.reg_dst    = 0;
                ctrl_if.ctrl.alu_src    = 1;
                ctrl_if.ctrl.branch     = 0;
                ctrl_if.ctrl.mem_write  = 1;
                ctrl_if.ctrl.mem_to_reg = 0;
                ctrl_if.ctrl.alu_ctrl = mips_pkg::ALU_ADD; 
            end mips_pkg::BEQ : begin
                ctrl_if.ctrl.reg_write  = 0;
                ctrl_if.ctrl.reg_dst    = 0;
                ctrl_if.ctrl.alu_src    = 0;
                ctrl_if.ctrl.branch     = 1;
                ctrl_if.ctrl.mem_write  = 0;
                ctrl_if.ctrl.mem_to_reg = 0;
                ctrl_if.ctrl.alu_ctrl   = mips_pkg::ALU_SUB;
            end mips_pkg::ADDI: begin
                ctrl_if.ctrl.reg_write  = 1;
                ctrl_if.ctrl.reg_dst    = 0;
                ctrl_if.ctrl.alu_src    = 1;
                ctrl_if.ctrl.branch     = 0;
                ctrl_if.ctrl.mem_write  = 0;
                ctrl_if.ctrl.mem_to_reg = 0;
                ctrl_if.ctrl.alu_ctrl   = mips_pkg::ALU_ADD;
            end
        endcase 
    end
endmodule
