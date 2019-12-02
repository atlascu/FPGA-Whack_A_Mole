module clock_divider_1Hz(input clock, reset, output reg new_clock);

parameter MAX = 50000000; 
reg [10:0] counter = 10'b0;

always @ (posedge clock or posedge reset) begin
    if (reset) begin
        new_clock <= 1'b0;
        counter <= 10'b0;      
    end else 
        if (counter == MAX) begin
            new_clock <= ~new_clock;
            counter <= 10'b0;
        end else begin
            counter <= counter + 1'b1;
        end

 end

endmodule
