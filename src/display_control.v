`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 06:31:30 PM
// Design Name: 
// Module Name: display_control
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

module display_control(clock, count, reset, digit_select, binary_out);
  input [31:0] count;
  input clock, reset;
  output reg [3:0] binary_out;
  output reg [7:0] digit_select; //Made this 8 bit to turn off the other four displays
  reg [2:0] select = 3'b000;
  
  //Counter behavoiral implementation
  always @(posedge clock or posedge reset) begin
    if (reset)
        select = 3'b00;
    else
        select = select + 1'b1;
  end

  //MUX behavoiral implementation
  always @(posedge clock) begin
    case (select)
      3'b000: begin
        digit_select <= 8'b11111110;
        binary_out <= count[3:0];
        end
      3'b001: begin
        digit_select <= 8'b11111101;
        binary_out <= count[7:4];
        end
      3'b010: begin
        digit_select <= 8'b11111011;
        binary_out <= count[11:8];
        end
      3'b011: begin
        digit_select <= 8'b11110111;
        binary_out <= count[15:12];
        end
        3'b100: begin
        digit_select <= 8'b11101111;
        binary_out <= count[19:16];
        end
      3'b101: begin
        digit_select <= 8'b11011111;
        binary_out <= count[23:20];
        end
      3'b110: begin
        digit_select <= 8'b10111111;
        binary_out <= count[27:24];
        end
      3'b111: begin
        digit_select <= 8'b01111111;
        binary_out <= count[31:28];
        end
       
    endcase
  end

endmodule
