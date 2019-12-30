`timescale 1s / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 09:32:18 AM
// Design Name: 
// Module Name: gameBeginControl
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


module gameBeginControl(game_begin, reset, clk);
    output reg [1:0] game_begin;
    input reset, clk;
    
    parameter day = 17'd86400; //this is the amount of seconds in a day, after which the program will restart as the counter rolls over
    reg [16:0] counter = 17'd1;
    
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            game_begin <= 2'b00;
            counter <= 17'd1;
        end else begin
            counter <= counter + 1'b1;
            if (counter < 17'd5) begin
                game_begin <= 2'b00;
            end else begin 
                if (counter < 17'd35) begin
                    game_begin <= 2'b01;
                end else begin
                    game_begin <= 2'b10;
                end
            end
        end
    end //always 
endmodule
