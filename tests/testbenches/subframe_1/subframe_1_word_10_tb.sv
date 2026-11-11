/**
 * @file subframe_1_word_10_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_10 module
 */
module subframe_1_word_10_tb();
    // inputs
    logic [21:0] af0;
    logic prev_parity0;
    logic prev_parity1;

    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_10 dut (
        .af0,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_10 ---- ");
        af0 = '0;
        prev_parity0 = 1;
        prev_parity1 = 0;
        #10;
        $display("Word 10: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_10_tb
