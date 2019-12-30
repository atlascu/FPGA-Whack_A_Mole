`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 11:47:02 AM
// Design Name: 
// Module Name: seven_segment_decoder
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

module seven_segment_decoder(binary_in, reset, display_out);
  input [3:0] binary_in;
  input       reset;
  output reg [6:0] display_out;
  

  //Otherwise set the display_out to the correct binary enconding
  always @(binary_in, reset) begin
    //If the reset is triggered turn off the display
    if (reset)
         display_out <= 7'b1111111;
    else begin
      case(binary_in)
        4'b0000: display_out <= 7'b0000001;
        4'b0001: display_out <= 7'b1001111;
        4'b0010: display_out <= 7'b0010010;
        4'b0011: display_out <= 7'b0000110;
        4'b0100: display_out <= 7'b1001100;
        4'b0101: display_out <= 7'b0100100;
        4'b0110: display_out <= 7'b0100000;
        4'b0111: display_out <= 7'b0001111;
        4'b1000: display_out <= 7'b0000000;
        4'b1001: display_out <= 7'b0000100;
        4'b1010: display_out <= 7'b0001000;
        4'b1011: display_out <= 7'b1100000;
        4'b1100: display_out <= 7'b0110001;
        4'b1101: display_out <= 7'b1000010;
        4'b1110: display_out <= 7'b0110000;
        4'b1111: display_out <= 7'b0111000;
      endcase
    end
  end
endmodule
