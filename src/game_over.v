`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 05:41:35 PM
// Design Name: 
// Module Name: game_over
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

//Used to keep the same score after 35 seconds of game time
module game_over(select, binary_in, latch_out, clk);
    input [31:0] binary_in;
    input [1:0] select;
    input clk;
    output reg [31:0] latch_out;
    reg latcher = 1'b0;
    
    always @(select, clk) begin
        if (select == 2'b10) begin
            if (latcher == 1'b0) begin
                latch_out <= binary_in;
                latcher <= 1'b1;
            end
        end
    end//always
          
endmodule
