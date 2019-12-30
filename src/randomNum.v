module randomNum(clk, reset, number);
input clk, reset;
output reg [2:0]number;

reg [2:0]next;
wire feedback = number[2]^number[1];

  always@(posedge clk or posedge reset) begin
   if (reset)
      number <= 3'b001;
   else
      number <= next;
   end //always statement

  always@(*) begin
    next <= {number[1:0], feedback}; 
  end //always statement
  
endmodule
