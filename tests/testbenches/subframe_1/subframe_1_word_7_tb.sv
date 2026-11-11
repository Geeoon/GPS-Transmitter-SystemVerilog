/**
 * @file subframe_1_word_7_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_7 module
 */
module subframe_1_word_7_tb();
    // inputs
    logic [15:0] reserved;
    logic [7:0] correction;
    logic prev_parity0;
    logic prev_parity1;
    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_7 dut (
        .reserved,
        .correction,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_7_tb ---- ");
        reserved = '0;
        correction = '0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("Word 7: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_7_tb
