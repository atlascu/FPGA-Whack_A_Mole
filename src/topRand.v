module topRand(clk, reset, displayL);
input clk, reset;
output [4:0]displayL;

wire [2:0]number;

randomNum rn(.clk(clk), .reset(reset), .number(number));
LEDdisplay ld(.number(number), .displayL(displayL));

endmodule


// I added portings to specify i/p, o/p
