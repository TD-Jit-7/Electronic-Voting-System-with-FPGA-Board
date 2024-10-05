`timescale 1ns / 1ps

module authentication(
  input clock,
  input reset,
  input anyValidVote,
  input [7:0] voter_id,
  output reg [255:0] voted
);

// might have the valid_votes and voted as inout

  always @(posedge clock)
  begin
  
	if (reset) voted = 0;
	else if (anyValidVote) voted[voter_id] = 1;
	
  end

endmodule
