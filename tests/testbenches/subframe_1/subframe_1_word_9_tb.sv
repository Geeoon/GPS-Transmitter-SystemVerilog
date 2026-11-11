/**
 * @file subframe_1_word_9_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_9 module
 */
module subframe_1_word_9_tb();
    // inputs
    logic [7:0] af2;
    logic [15:0] af1;
    logic prev_parity0;
    logic prev_parity1;
    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_9 dut (
        .af2,
        .af1,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_9_tb ---- ");
        af2 = '0;
        af1 = '0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("Word 9: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_9_tb
