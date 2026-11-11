/**
 * @file subframe_1_word_8_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_8 module
 */
module subframe_1_word_8_tb();
    // inputs
    logic [9:0] iodc;
    logic [15:0] toc;
    logic prev_parity0;
    logic prev_parity1;
    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_8 dut (
        .iodc,
        .toc,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_8_tb ---- ");
        iodc = '0;
        toc = '0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("Word 8: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_8_tb
