/**
 * @file word_parity.sv
 * @author Geeoon Chung
 * @brief combinational logic for (32,26) extended Hamming code used in words
 * @see http://nav-soft.com/GPSData.shtml
 * @param[in] prev_parity0  the previous subframe's bit 29 (second to last parity bit)
 * @param[in] prev_parity1  the previous subframe's bit 30 (last parity bit)
 * @param[in] data_bits     the data for the word (everything besides the last 6 parity bits)
 * @param[out] parity       the calculated parity
 */
/* verilator lint_off ASCRANGE */
module word_parity(
    input logic prev_parity0,
    input logic prev_parity1,
    input logic [1:24] data_bits,
    
    output logic [25:30] parity
);
/* verilator lint_on ASCRANGE */
    assign parity[25] = prev_parity0 ^ data_bits[1] ^ data_bits[2] ^ data_bits[3] ^ data_bits[5] ^ data_bits[6] ^ data_bits[10] ^ data_bits[11] ^ data_bits[12] ^ data_bits[13] ^ data_bits[14] ^ data_bits[17] ^ data_bits[18] ^ data_bits[20] ^ data_bits[23];
    assign parity[26] = prev_parity1 ^ data_bits[2] ^ data_bits[3] ^ data_bits[4] ^ data_bits[6] ^ data_bits[7] ^ data_bits[11] ^ data_bits[12] ^ data_bits[13] ^ data_bits[14] ^ data_bits[15] ^ data_bits[18] ^ data_bits[19] ^ data_bits[21] ^ data_bits[24];
    assign parity[27] = prev_parity0 ^ data_bits[1] ^ data_bits[3] ^ data_bits[4] ^ data_bits[5] ^ data_bits[7] ^ data_bits[8] ^ data_bits[12] ^ data_bits[13] ^ data_bits[14] ^ data_bits[15] ^ data_bits[16] ^ data_bits[19] ^ data_bits[20] ^ data_bits[22];
    assign parity[28] = prev_parity1 ^ data_bits[2] ^ data_bits[4] ^ data_bits[5] ^ data_bits[6] ^ data_bits[8] ^ data_bits[9] ^ data_bits[13] ^ data_bits[14] ^ data_bits[15] ^ data_bits[16] ^ data_bits[17] ^ data_bits[20] ^ data_bits[21] ^ data_bits[23];
    assign parity[29] = prev_parity1 ^ data_bits[1] ^ data_bits[3] ^ data_bits[5] ^ data_bits[6] ^ data_bits[7] ^ data_bits[9] ^ data_bits[10] ^ data_bits[14] ^ data_bits[15] ^ data_bits[16] ^ data_bits[17] ^ data_bits[18] ^ data_bits[21] ^ data_bits[22] ^ data_bits[24];
    assign parity[30] = prev_parity0 ^ data_bits[3] ^ data_bits[5] ^ data_bits[6] ^ data_bits[8] ^ data_bits[9] ^ data_bits[10] ^ data_bits[11] ^ data_bits[13] ^ data_bits[15] ^ data_bits[19] ^ data_bits[22] ^ data_bits[23] ^ data_bits[24];

endmodule  // word_parity
