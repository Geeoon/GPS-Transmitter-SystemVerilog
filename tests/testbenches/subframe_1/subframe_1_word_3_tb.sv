/**
 * @file subframe_1_word_3_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the subframe_1_word_3 module
 */
module subframe_1_word_3_tb();
    // inputs
    logic [9:0] week_number;
    logic [1:0] code;
    logic [3:0] ura_index;
    logic [5:0] sv_health;
    logic [9:0] iodc;
    logic prev_parity0;
    logic prev_parity1;

    // outputs
    logic [29:0] out;

    // dut
    subframe_1_word_3 dut (
        .week_number,
        .code,
        .ura_index,
        .sv_health,
        .iodc,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting subframe_1_word_3_tb ---- ");
        week_number = '0;
        code = '0;
        ura_index = '0;
        sv_health = '0;
        iodc = '0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("Word 3: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // subframe_1_word_3_tb
