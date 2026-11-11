/**
 * @file subframe_1_word_7.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe 1 word 7
 * @param[in] reserved      16 reserved bits, ignored by receiver
 * @param[in] correction    ionospheric correction term for P(Y) in L1 and L2; sign magnitude
 * @param[in] prev_parity0  bit 29 of the previous word (second to last parity bit)
 * @param[in] prev_parity1  bit 30 of the previous word (last parity bit)
 * @param[out] out          the word
 */
module subframe_1_word_7 (
    input logic [15:0] reserved,
    input logic [7:0] correction,
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

    assign data = { reserved, correction };
    assign out = { data, parity };

endmodule  // subframe_1_word_7
