`timescale 1ns / 1ps //switched for simpler functionallity
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
module top_wack_a_mole(digit_select, seven_seg, led_out, rgb_led, clk, reset, switch_in, level_select,);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    output [5:0] rgb_led;
    output [4:0] led_out;
    input        clk, reset, level_select;
    input  [4:0] switch_in;
	
	//Internal wires
    wire check_to_counter, clock_lHz, clock_lkHz, clock_2Hz, clock_choice;
    wire [1:0] game_begin;
    wire [3:0] dc_to_seven;
    wire [31:0] counter_to_mux, mux_to_bcd, bcd_to_dc, count_down, latch_out;
    wire [4:0] button_in_db, led_to_mux;
    wire [4:0] led_wait = 5'b00000;
      
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.new_clock(clock_lHz), .clock(clk), .reset(reset));
    clock_divider_1kHz cd2(.clk_1kHz(clock_lkHz), .clk_100MHz(clk), .reset(reset));
    clock_divider_2Hz cd3(.new_clock(clock_2Hz), .clock(clk), .reset(reset));
    
    //Choose the level(fast vs slow)
    assign clock_choice = (level_select) ? clock_2Hz : clock_lHz;
    
    //Create the 30 second countdown path
    topRand tr(.displayL(led_to_mux), .clk(clock_choice), .reset(reset));
    checkInput ci(.out(check_to_counter), .rand_in(led_to_mux), .switch_in(switch_in), .reset(reset));
    counter32 c(.count(counter_to_mux), .inc(check_to_counter), .clock(clock_choice), .reset(reset));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.countout(count_down), .clk(clock_lHz), .reset(reset));
    
    //Create the end game score
    game_over go(.latch_out(latch_out), .select(game_begin), .binary_in(counter_to_mux), .clk(clk));
    
    //Switch between the 5 second countdown and 30 second game and the end game score
    gameBeginControl gb(.game_begin(game_begin), .reset(reset), .clk(clock_lHz));
    assign mux_to_bcd = (game_begin==2'b00) ? count_down : (game_begin==2'b01)? counter_to_mux: latch_out;
    assign led_out = (game_begin==2'b01) ? led_to_mux : led_wait;
    
    //Change color of rgb leds based on difficulty
    assign rgb_led = (game_begin==2'b01) ? (level_select) ? 6'b100100 : 6'b010010 : 6'b000000;
    
    //Conver the score to BCD
    binary2BCD bcd(mux_to_bcd, bcd_to_dc);
    
    //Create the display control path post BCD
    display_control dc(.digit_select(digit_select), .binary_out(dc_to_seven), .count(bcd_to_dc), .clock(clock_lkHz), .reset(reset));
    seven_segment_decoder ss(.display_out(seven_seg), .binary_in(dc_to_seven), .reset(reset));
    
endmodule
