/**
 * @file word_1_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the word_1 module
 */
module word_1_tb();
    // inputs
    logic [13:0] tlm;
    logic integrity;
    logic reserved;
    logic prev_parity0;
    logic prev_parity1;

    // outputs
    logic [29:0] out;

    // dut
    word_1 dut (
        .tlm,
        .integrity,
        .reserved,
        .prev_parity0,
        .prev_parity1,

        .out
    );

    initial begin
        $display(" ---- Starting word_1_tb ---- ");
        tlm = '0;
        integrity = 0;
        reserved = 0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        #10;
        $display("TLM word: %b", out);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // word_1_tb
