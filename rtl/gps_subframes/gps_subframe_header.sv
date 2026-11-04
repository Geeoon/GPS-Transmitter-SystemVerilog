/**
 * @file gps_subframe_header.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe header (TLM word and HOW)
 * @param[in] tlm           telemetry supposed to be hard-coded, ignored by receivers. bits 9-22 for word 1
 * @param[in] integrity     the integrity of the satellite (0 for normal, 1 for low integrity). bit 23 for word 1
 * @param[in] reserved      a reserved bit, ignored by receivers. bit 24 for word 1
 * @param[in] prev_parity0  bit 29 of the previous subframe (second to last parity bit). set to 0 on reset
 * @param[in] prev_parity1  bit 30 of the previous subframe (last parity bit). set to 0 on reset
 * @param[in] tow_count     time of week, the number of 6-second periods since Sunday
 * @param[in] alert         whether or not the accuracy is satellite is healthy, should be set to 0 if normal
 * @param[in] antispoof     whether or not the P(Y) code is enabled, real GPS signals will set this to 1
 * @param[in] subframe_id   the subframe that this header belongs to
 * @param[out] out          the calculated first two words for each subframe
 */
module gps_subframe_header #(
    localparam bit [7:0] PREAMBLE=8'b10001011
) (
    // TLM
    input logic [13:0] tlm,
    input logic integrity,
    input logic reserved,
    input logic prev_parity0,
    input logic prev_parity1,


    // HOW
    input logic [16:0] tow_count,
    input logic alert,
    input logic antispoof,
    input logic[2:0] subframe_id,

    output logic [59:0] out

);
    /* verilator lint_off ASCRANGE */
    // intermediate signals
    logic [1:24] tlm_data;  // TLM word without parity
    logic [25:30] tlm_parity;

    logic [1:22] how_data;  // HOW without parity or padding
    logic padding0, padding1;  // padding used for parity calculation
    logic [25:30] how_parity;  // the actual parity sent over
    /* verilator lint_on ASCRANGE */

    // wire assignments
    assign tlm_data = { PREAMBLE, tlm, integrity, reserved };
    assign how_data = { tow_count, alert, antispoof, subframe_id };

    // submodules
    word_parity tlm_parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits(tlm_data),
        
        .parity(tlm_parity)
    );

    word_solved_parity how_parity_m (
        .prev_parity0(tlm_parity[29]),
        .prev_parity1(tlm_parity[30]),
        .data_bits(how_data),

        .padding0,
        .padding1,
        .parity(how_parity)
    );

    assign out = { tlm_data, tlm_parity, how_data, padding0, padding1, how_parity };

endmodule  // gps_subframe_header
