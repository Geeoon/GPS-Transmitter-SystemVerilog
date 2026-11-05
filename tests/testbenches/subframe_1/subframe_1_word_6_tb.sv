/**
 * @file subframe_1_word_6_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_6 module
 */
module subframe_1_word_6_tb();
    // inputs
    logic [23:0] reserved;
    logic prev_parity0;
    logic prev_parity1;
    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_6 dut (
        .reserved,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_6_tb ---- ");
        reserved = '0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("Word 6: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_6_tb
