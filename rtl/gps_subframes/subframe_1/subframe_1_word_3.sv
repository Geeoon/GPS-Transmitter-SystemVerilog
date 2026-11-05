/**
 * @file subframe_1_word_3.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe 1 word 3
 * @param[in] week_number   the current week number (weeks since last rollover, Aug 6 2019 as of 2026)
 * @param[in] code          P-CODE (1) or C/A CODE (2).  Other values are "invalid".
 * @param[in] ura_index     accuracy of this satellite
 * @param[in] sv_health     health of the satellite ('0 for full health)
 * @param[in] iodc          2 MSB's of the issue of data clock
 */
module subframe_1_word_3 (
    input logic [9:0] week_number,
    input logic [1:0] code,
    input logic [3:0] ura_index,
    input logic [5:0] sv_health,
    input logic [9:0] iodc,
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

    assign data = { week_number, code, ura_index, sv_health, iodc[9:8] };
    assign out = { data, parity };

endmodule  // subframe_1_word_3
