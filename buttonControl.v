`timescale 1ns / 1ps

module buttonControl(
input clock,
input reset,
input button,
input mode,
input pollsig,
input [7:0] voter_id,
input [255:0] voted,
output reg valid_vote
);

reg [24:0] counter;

always @(posedge clock)
begin
	if(reset | mode | ~pollsig)
        counter = 0;
    else
    begin
        if(button & counter < 25000001)
            counter = counter + 1;
        else if(!button)
            counter = 0;
    end
end


always @(posedge clock)
begin
    if(reset)
        valid_vote = 1'b0;
    else
    begin
        if(counter == 25000000 & ~voted[voter_id])
            valid_vote = 1'b1;
        else
            valid_vote = 1'b0;
    end
end

endmodule
