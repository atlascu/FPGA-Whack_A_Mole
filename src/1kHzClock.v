`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 06:31:30 PM
// Design Name: 
// Module Name: clock_divider
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
module clock_divider_1kHz(clk_100MHz, clk_1kHz, reset);
  input clk_100MHz, reset;
  output reg clk_1kHz = 1'b0;
  reg [15:0] duty_cycle = 16'b0;
  
  always @(posedge clk_100MHz or posedge reset) begin
    if (reset) begin
      duty_cycle <= 16'b0;
      clk_1kHz <= 1'b0;
    end else begin
      if (duty_cycle == 16'd50000) begin
        duty_cycle <= 16'b0;
        clk_1kHz <= !clk_1kHz;
      end else begin
        duty_cycle <= duty_cycle + 1'b1;
      end
    end
  end //always
  
endmodule
