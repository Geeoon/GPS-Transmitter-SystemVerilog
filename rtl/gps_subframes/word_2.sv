/**
 * @file word_2.sv
 * @author Geeoon Chung
 * @brief second word for every subframe, handoff word
 * @param[in] tow_count     time of week, the number of 6-second periods since Sunday
 * @param[in] alert         whether or not the accuracy is satellite is healthy, should be set to 0 if normal
 * @param[in] antispoof     whether or not the P(Y) code is enabled, real GPS signals will set this to 1
 * @param[in] subframe_id   the subframe that this header belongs to
 * @param[out] out          the full word
 */
module word_2 (
    input logic [16:0] tow_count,
    input logic alert,
    input logic antispoof,
    input logic [2:0] subframe_id,
    input logic prev_parity0,
    input logic prev_parity1,

    output logic [29:0] out
);
    // intermediate signals
    /* verilator lint_off ASCRANGE */
    logic [1:22] how_data;  // HOW without parity or padding
    logic padding0, padding1;  // padding used for parity calculation
    logic [25:30] how_parity;  // the actual parity sent over
    /* verilator lint_on ASCRANGE */

    // submodules
    word_solved_parity how_parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits(how_data),

        .padding0,
        .padding1,
        .parity(how_parity)
    );
    assign out = { how_data, padding0, padding1, how_parity };
endmodule  // word_2
