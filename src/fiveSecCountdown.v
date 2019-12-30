`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 06:02:10 PM
// Design Name: 
// Module Name: fiveSecCountdown
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


module fiveSecCountdown(countout, clk, reset);

input            clk, reset;
output reg [31:0] countout = 32'd5;

always @(posedge clk, posedge reset) begin
    if (reset || countout == 32'd1) 
    begin
      countout <= 32'd5;
    end
    else begin
        countout <= countout - 1'd1;
    end
end
   
endmodule
