/**
 * @file subframe_1_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the word_1 module
 */
module gps_subframe_1_tb #(
    localparam CLOCK_PERIOD=100
) ();
    // inputs
    logic clk;
    logic rst;
    logic en;
    // WORD 1
    logic [13:0] tlm;
    logic integrity;
    logic reserved_word_1;
    // WORD 2
    logic [16:0] tow_count;
    logic alert;
    logic antispoof;
    logic [2:0] subframe_id;
    // WORD 3
    logic [9:0] week_number;
    logic [1:0] code;
    logic [3:0] ura_index;
    logic [5:0] sv_health;
    logic [9:0] iodc;  // also used for word 8
    // WORD 4
    logic p_code;
    logic [22:0] reserved_word_4;
    // WORD 5
    logic [23:0] reserved_word_5;
    // WORD 6
    logic [23:0] reserved_word_6;
    // WORD 7
    logic [15:0] reserved_word_7;
    logic [7:0] correction;
    // WORD 8
    // logic [9:0] iodc;  // same as word 3
    logic [15:0] toc;
    // WORD 9
    logic [7:0] af2;
    logic [15:0] af1;
    // WORD 10
    logic [21:0] af0;
    // output
    logic [29:0] word;
    logic done;

    // dut
    gps_subframe_1 dut (
        .clk,
        .rst,
        .en,
        .tlm,
        .integrity,
        .reserved_word_1,
        .tow_count,
        .alert,
        .antispoof,
        .subframe_id,
        .week_number,
        .code,
        .ura_index,
        .sv_health,
        .iodc,
        .p_code,
        .reserved_word_4,
        .reserved_word_5,
        .reserved_word_6,
        .reserved_word_7,
        .correction,
        .toc,
        .af2,
        .af1,
        .af0,
        .word,
        .done
    );

    initial begin
        clk = 0;
        forever begin
            #(CLOCK_PERIOD/2) clk = ~clk;
        end  // forever
    end  // initial

    initial begin
        $display(" ---- Starting subframe_1_tb ---- ");
        // RESET
        rst = 1;
        en = 0;
        tlm = '0;
        integrity = 0;
        reserved_word_1 = 0;
        tow_count = 0;
        alert = 0;
        antispoof = 0;
        subframe_id = '0;
        week_number = '0;
        code = '0;
        ura_index = '0;
        sv_health = '0;
        iodc = '0;  // also used for word 8
        p_code = '0;
        reserved_word_4 = '0;
        reserved_word_5 = '0;
        reserved_word_6 = '0;
        reserved_word_7 = '0;
        correction = '0;
        toc = '0;
        af2 = '0;
        af1 = '0;
        af0 = '0;

        @(posedge clk); #5;
        rst = 0;

        repeat(10) begin
            for (int i = 1; i <= 10; i++) begin
                repeat(100) @(posedge clk);
                #5;
                $display("Word %2d: %b", i, word);
                assert(done == (i == 10));
                en = 1;
                @(posedge clk); #5;
                en = 0;
            end  // for
        end  // repeat

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // gps_subframe_1
