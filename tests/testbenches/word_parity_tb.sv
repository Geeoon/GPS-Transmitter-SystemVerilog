/**
 * @file word_parity_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the word_parity module
 */
module word_parity_tb();
    /* verilator lint_off ASCRANGE */
    // inputs
    logic prev_parity0, prev_parity1;
    logic [1:24] data_bits;
    // outputs
    logic [5:0] parity;
    /* verilator lint_on ASCRANGE */

    // dut
    word_parity dut (
        .prev_parity0,
        .prev_parity1,
        .data_bits,

        .parity
    );

    initial begin
        $display(" ---- Starting word_parity_tb ---- ");
        prev_parity0 = 0;
        prev_parity1 = 0;
        data_bits = '0;
        #10;
        assert(parity == '0);
        
        prev_parity0 = 1;
        prev_parity1 = 0;
        #10;
        assert(parity == 6'b101001);
        
        prev_parity0 = 0;
        prev_parity1 = 1;
        #10;
        assert(parity == 6'b010110);

        prev_parity0 = 1;
        prev_parity1 = 1;
        #10;
        assert(parity == 6'b111111);

        prev_parity0 = 0;
        prev_parity1 = 0;
        data_bits = '1;
        #10;
        assert(parity == 6'b000011);

        prev_parity0 = 1;
        prev_parity1 = 1;
        data_bits = '1;
        #10;
        assert(parity == 6'b111100);

        $display(" ---- Testbench finished ---- ");
    end  // initial
endmodule  // word_parity_tb
