`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 06:24:08 PM
// Design Name: 
// Module Name: checkInput
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


module checkInput(reset, rand_in, switch_in, out);

input  reset;
input  [4:0] rand_in, switch_in;
output  out;

wire reset;
wire [4:0] rand_in, switch_in;

assign out = (reset)? 0 : (rand_in == switch_in)? 1 : 0;

endmodule
