/**
 * @file gps_subframe_1.sv
 * @author Geeoon Chung
 * @brief sequential logic to create a gps subframe 1
 * @param[in] clk       the clock driving the circuit
 * @param[in] rst       reset signal
 * @param[in] en        enable signal to generate the next word
 * @param[out] word     the word to send
 * @param[out] done     whether this is the last word of the subframe
 */
module gps_subframe_1 #(
    localparam LFSR_RESET=4'b0110
) (
    input logic clk,
    input logic rst,
    input logic en,
    
    // WORD 1
    input logic [13:0] tlm,
    input logic integrity,
    input logic reserved_word_1,

    // WORD 2
    input logic [16:0] tow_count,
    input logic alert,
    input logic antispoof,
    input logic [2:0] subframe_id,

    // WORD 3
    input logic [9:0] week_number,
    input logic [1:0] code,
    input logic [3:0] ura_index,
    input logic [5:0] sv_health,
    input logic [9:0] iodc,  // also used for word 8

    // WORD 4
    input logic p_code,
    input logic [22:0] reserved_word_4,

    // WORD 5
    input logic [23:0] reserved_word_5,

    // WORD 6
    input logic [23:0] reserved_word_6,

    // WORD 7
    input logic [15:0] reserved_word_7,
    input logic [7:0] correction,

    // WORD 8
    // input logic [9:0] iodc,  // same as word 3
    input logic [15:0] toc,

    // WORD 9
    input logic [7:0] af2,
    input logic [15:0] af1,

    // WORD 10
    input logic [21:0] af0,

    // output
    output logic [29:0] word,
    output logic done
);
    // FSM
    logic [3:0] lfsr_ps;
    logic [3:0] lfsr_ns;

    // intermediate signals
    logic prev_parity0;
    logic prev_parity1;
    logic parity0;
    logic parity1;
    logic [29:0] word_1_out;
    logic [29:0] word_2_out;
    logic [29:0] word_3_out;
    logic [29:0] word_4_out;
    logic [29:0] word_5_out;
    logic [29:0] word_6_out;
    logic [29:0] word_7_out;
    logic [29:0] word_8_out;
    logic [29:0] word_9_out;
    logic [29:0] word_10_out;

    // submodules
    word_1 word_1_m (
        .tlm,
        .integrity,
        .reserved(reserved_word_1),
        .prev_parity0,
        .prev_parity1,
        .out(word_1_out)
    );
    word_2 word_2_m (
        .tow_count,
        .alert,
        .antispoof,
        .subframe_id,
        .prev_parity0,
        .prev_parity1,
        .out(word_2_out)
    );
    subframe_1_word_3 word_3_m (
        .week_number,
        .code,
        .ura_index,
        .sv_health,
        .iodc,
        .prev_parity0,
        .prev_parity1,
        .out(word_3_out)
    );
    subframe_1_word_4 word_4_m (
        .p_code,
        .reserved(reserved_word_4),
        .prev_parity0,
        .prev_parity1,
        .out(word_4_out)
    );
    subframe_1_word_5 word_5_m (
        .reserved(reserved_word_5),
        .prev_parity0,
        .prev_parity1,
        .out(word_5_out)
    );
    subframe_1_word_6 word_6_m (
        .reserved(reserved_word_6),
        .prev_parity0,
        .prev_parity1,
        .out(word_6_out)
    );
    subframe_1_word_7 word_7_m (
        .reserved(reserved_word_7),
        .correction,
        .prev_parity0,
        .prev_parity1,
        .out(word_7_out)
    );
    subframe_1_word_8 word_8_m (
        .iodc,
        .toc,
        .prev_parity0,
        .prev_parity1,
        .out(word_8_out)
    );
    subframe_1_word_9 word_9_m (
        .af2,
        .af1,
        .prev_parity0,
        .prev_parity1,
        .out(word_9_out)  
    );
    subframe_1_word_10 word_10_m (
        .af0,
        .prev_parity0,
        .prev_parity1,
        .out(word_10_out)
    );

    assign parity0 = word[1];
    assign parity1 = word[0];

    always_comb begin
        lfsr_ns = { lfsr_ps[2:0], lfsr_ps[3] ^ lfsr_ps[0] };
        done = 0;
        case (lfsr_ps)
            4'b0110: word = word_1_out;  // WORD 1
            4'b1100: word = word_2_out;  // WORD 2
            4'b1001: word = word_3_out;  // WORD 3
            4'b0010: word = word_4_out;  // WORD 4
            4'b0100: word = word_5_out;  // WORD 5
            4'b1000: word = word_6_out;  // WORD 6
            4'b0001: word = word_7_out;  // WORD 7
            4'b0011: word = word_8_out;  // WORD 8
            4'b0111: word = word_9_out;  // WORD 9
            4'b1111: begin               // WORD 10 
                lfsr_ns = LFSR_RESET;
                word = word_10_out;
                done = 1;
            end
            default: begin  // lfsr is in an invalid state
                word = '0;
                lfsr_ns = LFSR_RESET;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            prev_parity0 <= 0;
            prev_parity1 <= 0;
            lfsr_ps <= LFSR_RESET;
        end else if (en) begin
            prev_parity0 <= parity0;
            prev_parity1 <= parity1;
            lfsr_ps <= lfsr_ns;
        end
    end  // always_ff
endmodule  // gps_subframe_1
