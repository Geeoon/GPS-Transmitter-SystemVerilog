/**
 * @file word_solved_parity.sv
 * @author Geeoon Chung
 * @brief used for word 2 and 10 of a subframe. solves padding to make last 2 parity bits equal to zero
 * @param[in] prev_parity0  the previous subframe's bit 29 (second to last parity bit)
 * @param[in] prev_parity1  the previous subframe's bit 30 (last parity bit)
 * @param[in] data_bits     the data for the word (everything besides the last 6 parity bits)
 * @param[out] padding0     the first padding bit, the 23rd bit
 * @param[out] padding1     the second padding bit, the 24th bit
 * @param[out] parity       the output parity
 */
/* verilator lint_off ASCRANGE */
module word_solved_parity (
    input logic prev_parity0,
    input logic prev_parity1,
    input logic [1:22] data_bits,
    
    output logic padding0,
    output logic padding1,
    output logic [25:30] parity
);
    // intermediate signals
    logic [25:30] int_parity;  // the intermediate parity calculation
/* verilator lint_on ASCRANGE */

    // submodules
    word_parity parity_m (
        .prev_parity0,
        .prev_parity1,
        .data_bits({ data_bits, 2'b00 }),

        .parity(int_parity)
    );

    // parity last two bits of how data calculation
    // to set D_29 to 0, we set `padding1 = D_29`
    // to set D_30 to 0, we set padding0 ^ padding1 = D_30
    // since we know padding1, we can set `padding0 = D_30 ^ padding1`
    // because padding1 is used to calculate D_26
    //      `D_26 ^= padding1`
    // because padding0 is used to calculate D_25 and D_28
    //      `D_25 ^= padding0`
    //      `D_28 ^= padding0`
    assign padding0 = int_parity[30] ^ padding1;
    assign padding1 = int_parity[29];
    assign parity[25] = int_parity[25] ^ padding0;
    assign parity[26] = int_parity[26] ^ padding1;
    assign parity[27] = int_parity[27];
    assign parity[28] = int_parity[28] ^ padding0;
    assign parity[29] = int_parity[29] ^ padding1;
    assign parity[30] = int_parity[30] ^ padding0 ^ padding1;

endmodule  // word_solved_parity
