/**
 * @file gps_subframe_header.sv
 * @author Geeoon Chung
 * @brief combinational logic to create a gps subframe header (TLM word and HOW)
 * @param[in] tlm       telemetry supposed to be hard-coded, ignored by receivers
 * @param[in] integrity the integrity of the satellite (0 for normal, 1 for low integrity)
 * @param[in] reserved  a reserved bit, ignored by receivers
 * @param[in] tow       time of week, the number of 6-second periods since Sunday

 */
module gps_subframe_header #(
    localparam bit [7:0] PREAMBLE=8'b10001011,
    localparam
) (
    // TLM
    input logic [13:0] tlm,
    input logic integrity,
    input logic reserved,


    // HOW
    input logic [16:0] tow,
    input logic alert,
    input logic antispoof,
    input logic subframe_id

    output logic [59:0] out

);
    logic [5:0] tlm_parity;

    logic padding0, padding1;
    logic [5:0] how_parity;

    assign out = { preamble, tlm, integrity, reserved, tlm_partiy, tow, alert, antispoof, subframe_id, padding0, padding1, how_parity[5:2], 2'b00 };
endmodule  // gps_subframe_header
