`timescale 1ns / 1ps

module modeControl(
input clock,
input reset,
input mode,
input valid_vote_casted,
input [6:0] candidate1_vote,
input [6:0] candidate2_vote,
input [6:0] candidate3_vote,
input candidate1_button_press,
input candidate2_button_press,
input candidate3_button_press,
output [6:0] digit0,
output [6:0] digit1
    );
    
reg [6:0] num;

initial num = 100;

//mode0 -> voting mode, mode 1 -> result mode
    
always @(posedge clock)
begin
    if(reset) begin
        num = 0;
    end
    
    else
    begin
		if(~mode)							// mode = 0 -> voting mode
			num = 100;						// No digits displayed

		else 								// mode = 1 -> result mode
			begin
				if(candidate1_button_press)
					num = candidate1_vote;
				else if(candidate2_button_press)
					num = candidate2_vote;
				else if(candidate3_button_press)
					num = candidate3_vote;
			end
    end  
end

//digitsDisplay display_votes(.num(num), .digit0(digit0), digit1(digit1));
digitsDisplay display_votes(num, digit0, digit1);

endmodule
