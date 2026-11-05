/**
 * @file word_2_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the word_2 module
 */
module word_2_tb();
    // inputs
    logic [16:0] tow_count;
    logic alert;
    logic antispoof;
    logic [2:0] subframe_id;
    logic prev_parity0;
    logic prev_parity1;

    // outputs
    logic [29:0] out;

    // dut
    word_2 dut (
        .tow_count,
        .alert,
        .antispoof,
        .subframe_id,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting word_2_tb ---- ");
        tow_count = '0;
        alert = 0;
        antispoof = 0;
        subframe_id = '0;
        prev_parity0 = 1;
        prev_parity1 = 0;
        #10;
        $display("HOW word: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // word_2_tb
