module LEDdisplay(number, displayL);
input [2:0] number;
output reg [4:0] displayL;

  always@(number, displayL) begin

        case(number)
        3'b000: begin
            displayL <= 5'b00010;
        end
        
        3'b001: begin
          displayL <= 5'b00001;
        end

        3'b010: begin
          displayL <= 5'b01000;
        end

        3'b011: begin
          displayL <= 5'b00010;
        end

        3'b100: begin
         displayL <= 5'b00100;
        end

        3'b101: begin
          displayL <= 5'b10000;
        end

        3'b110: begin
          displayL <= 5'b01000;
        end

        3'b111: begin
          displayL <= 5'b00001;
        end

      endcase

  end // always statement


endmodule
