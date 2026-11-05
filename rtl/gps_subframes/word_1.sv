/**
 * @file word_1.sv
 * @author Geeoon Chung
 * @brief first word for every subframe, telemetry word
 * @param[in] tlm           telemetry supposed to be hard-coded, ignored by receivers. bits 9-22 for word 1
 * @param[in] integrity     the integrity of the satellite (0 for normal, 1 for low integrity). bit 23 for word 1
 * @param[in] reserved      a reserved bit, ignored by receivers. bit 24 for word 1
 * @param[in] prev_parity0  bit 29 of the previous subframe (second to last parity bit). set to 0 on reset
 * @param[in] prev_parity1  bit 30 of the previous subframe (last parity bit). set to 0 on reset
 * @param[out] out          the full word
 */
module word_1 #(
    localparam bit [7:0] PREAMBLE=8'b10001011
) (
    input logic [13:0] tlm,
    input logic integrity,
    input logic reserved,
    input logic prev_parity0,
    input logic prev_parity1,

    output logic [29:0] out
);
    // intermediate signals
    /* verilator lint_off ASCRANGE */
    logic [1:24] tlm_data;  // TLM word without parity
    logic [25:30] tlm_parity;
    /* verilator lint_on ASCRANGE */

    // submodules
    word_parity tlm_parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits(tlm_data),
        
        .parity(tlm_parity)
    );

    assign tlm_data = { PREAMBLE, tlm, integrity, reserved };

    assign out = { tlm_data, tlm_parity };
endmodule  // word_1
