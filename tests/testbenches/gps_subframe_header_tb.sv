/**
 * @file gps_subframe_header_tb.sv
 * @author Geeoon Chung
 * @brief testbench for the gps_subframe_header module
 */
module gps_subframe_header_tb();
    // inputs
    // TLM
    logic [13:0] tlm;
    logic integrity;
    logic reserved;
    logic prev_parity0;
    logic prev_parity1;
    // HOW
    logic [16:0] tow_count;
    logic alert;
    logic antispoof;
    logic [2:0] subframe_id;

    // outputs
    logic [59:0] out;

    // dut
    gps_subframe_header dut (
        .tlm,
        .integrity,
        .reserved,
        .prev_parity0,
        .prev_parity1,
        .tow_count,
        .alert,
        .antispoof,
        .subframe_id,

        .out
    );

    initial begin
        $display(" ---- Starting gps_subframe_header_tb ---- ");
        tlm = '0;
        integrity = 0;
        reserved = 0;
        prev_parity0 = 0;
        prev_parity1 = 0;
        tow_count = '0;
        alert = 0;
        antispoof = 0;
        subframe_id = 0;
        #10;
        $display("TLM word: %b", out[59:30]);
        $display("HOW word: %b", out[29:0]);

        $display(" ---- Testbench finished ---- ");
        $finish;
    end  // initial
endmodule  // gps_subframe_header_tb
