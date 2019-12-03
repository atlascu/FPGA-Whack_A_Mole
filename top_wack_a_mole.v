`timescale 1s / 1ps //switched for simpler functionallity
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 06:47:18 PM
// Design Name: 
// Module Name: top_wack_a_mole
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//Partial top module, 5 second countdown not fully implemented
module top_wack_a_mole(clk, reset, switch_in, digit_select, seven_seg, led_out);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    output [4:0] led_out;
    input        clk, reset;
    input  [4:0] switch_in;
    wire check_to_counter,clock_lHz, clock_lkHz, reset_debounced;
    wire [4:0] rand_to_check;
    wire [3:0] dc_to_seven;
    wire [31:0] counter_to_mux, mux_to_dc, count_down;
    reg game_begin;
   
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.clock(clk), .reset(reset), .new_clock(clock_lHz));
    clock_divider_1kHz cd2(.clk_100MHz(clk), .clk_1kHz(clock_lkHz), .reset(reset));
    
    //Create the 30 second countdown path
    topRand tr(.clk(clk), .reset(reset), .displayL(rand_to_check));
    checkInput ci(.reset(reset), .rand_in(rand_to_check), .switch_in(switch_in), .out(check_to_counter));
    counter32 c(.count(counter_to_mux), .reset(reset), .inc(check_to_counter), .clock(clk));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.countout(count_down), .clk(clock_lHz), .reset(reset));
    
    //Create the MUX
    assign mux_to_dc = (game_begin) ? counter_to_mux : count_down;
    
    //Create the display control path post MUX
    display_control dc(.clock(clock_lkHz), .count(mux_to_dc), .reset(reset), .digit_select(digit_select), .binary_out(dc_to_seven));
    seven_segment_decoder ss(.binary_in(dc_to_seven), .reset(reset), .display_out(seven_seg));
    
    //Switch between the 5 second countdown and 30 second game
    always @(posedge reset) begin
        game_begin = 1'b0;
        #5 game_begin = 1'b1;
    end
    
    //assign led_out to the output of the rand module
    assign led_out = rand_to_check;
    
endmodule