module mips_alu (
    input mips_pkg::alu_op_e opcode_i,
    input logic [31:0]       operand_a_i,
    input logic [31:0]       operand_b_i,

    output logic [31:0]     result_o,
    output logic            zero_o
);  
    logic [31:0] condinvb, sum;

    assign condinvb = opcode_i[2] ? ~operand_b_i : operand_b_i;
    assign sum = operand_a_i + condinvb + opcode_i[2];

    always_comb begin: result_select
        unique case (opcode_i[1:0])
            2'b00 : result_o = operand_a_i & operand_b_i;
            2'b01 : result_o = operand_a_i | operand_b_i;
            2'b10 : result_o = sum;
            2'b11 : result_o = sum[31];
        endcase
    end: result_select

    assign zero_o = |result_o;
endmodule