/**
 * @file subframe_1_word_10.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe 1 word 10
 * @param[in] af2           af2 correction term
 * @param[in] af1           af1 correction term
 * @param[in] prev_parity0  bit 29 of the previous word (second to last parity bit)
 * @param[in] prev_parity1  bit 30 of the previous word (last parity bit)
 * @param[out] out          the word
 */
module subframe_1_word_10 (
    input logic [21:0] af0,
    input logic prev_parity0,
    input logic prev_parity1,

    output logic [29:0] out
);
    // intermediate signals
    /* verilator lint_off ASCRANGE */
    logic [1:22] data;  // data without parity or padding
    logic padding0, padding1;  // padding used for parity calculation
    logic [25:30] parity;  // the actual parity sent over
    /* verilator lint_on ASCRANGE */

    // submodules
    word_solved_parity parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits(data),

        .padding0,
        .padding1,
        .parity(parity)
    );

    assign data = { af0 };
    assign out = { data, padding0, padding1, parity };

endmodule  // subframe_1_word_10
