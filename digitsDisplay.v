`timescale 1ns / 1ps

module digitsDisplay (
	input [6:0] num,
    output reg [6:0] digit0, // 7-bit output for segments a to g of digit 0
    output reg [6:0] digit1 // 7-bit output for segments a to g of digit 1
);

wire [6:0] segment_data[0:9]; // Data for segments a to g for digits 0 to 9

// Define 7-segment patterns for digits 0 to 9

assign segment_data[0] = 7'b0000001; // 0
assign segment_data[1] = 7'b1001111; // 1
assign segment_data[2] = 7'b0010010; // 2
assign segment_data[3] = 7'b0000110; // 3
assign segment_data[4] = 7'b1001100; // 4
assign segment_data[5] = 7'b0100100; // 5
assign segment_data[6] = 7'b0100000; // 6
assign segment_data[7] = 7'b0001111; // 7
assign segment_data[8] = 7'b0000000; // 8
assign segment_data[9] = 7'b0000100; // 9


// Display the number
always @(*) begin
    if (num >= 0 && num <= 99) begin
        digit1 = segment_data[num / 10]; // Set segments for digit 1
        digit0 = segment_data[num % 10]; // Set segments for digit 0
    end 
	else begin
        digit0 = 7'b1111111; // Display 'Err' if input is out of range
        digit1 = 7'b1111111;
    end
end

endmodule
