module debouncer#(parameter MAX=1000000)(
input clock,
input reset,
input button_in,
output reg button_out);

reg [31:0] deb_count;

always @(posedge clock) begin
    if(reset)
        deb_count <= 0;
    else if (button_in)
        deb_count <= deb_count + 1;
    else
    deb_count <= 0;
    end
    
always@(posedge clock) begin
    if(reset)
    button_out <= 1'b0;
    else if(deb_count == MAX)
    button_out <= 1'b1;
    else
    button_out <= 1'b0;
end
        
endmodule
