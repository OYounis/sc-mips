module mips_regfile (
    //clock and reset
    input logic              clk_i,
    input logic              nrst_i,
    //write port
    input logic              we_i,
    input logic [4:0]        waddr_i,
    input logic [31:0]       wdata_i,
    //read port
    input logic  [1:0][4:0]  raddr_i,
    output logic [1:0][31:0] rdata_o
);

    logic [31:0][31:0] mem;
    
    assign rdata_o = {mem[raddr_i[1]], mem[raddr_i[0]]};  
    
    always_ff @(posedge clk_i, negedge nrst_i) begin: reset_and_write
        if(!nrst_i) mem = '0;
        else if(we_i && (waddr_i != 0)) mem[waddr_i] = wdata_i;
    end: reset_and_write
    
endmodule
