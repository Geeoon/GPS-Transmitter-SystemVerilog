/**
 * @file subframe_1_word_5.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe 1 word 5
 * @param[in] reserved      24 reserved bits, ignored by receiver
 * @param[in] prev_parity0  bit 29 of the previous word (second to last parity bit)
 * @param[in] prev_parity1  bit 30 of the previous word (last parity bit)
 * @param[out] out          the word
 */
module subframe_1_word_5 (
    input logic [23:0] reserved,
    input logic prev_parity0,
    input logic prev_parity1,

    output logic [29:0] out
);
    // intermediate signals
    logic [23:0] data;
    logic [5:0] parity;

    // submodules
    word_parity parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits(data),
        
        .parity(parity)
    );

    assign data = reserved;
    assign out = { data, parity };

endmodule  // subframe_1_word_5
