`timescale 1ns / 1ps

module voteLogger(
input clock,
input reset,
input mode,
input cand1_vote_valid,
input cand2_vote_valid,
input cand3_vote_valid,
output reg [6:0] cand1_vote_recvd,
output reg [6:0] cand2_vote_recvd,
output reg [6:0] cand3_vote_recvd
);


always @(posedge clock)
begin
    if(reset)
    begin
        cand1_vote_recvd <= 0;
        cand2_vote_recvd <= 0;
        cand3_vote_recvd <= 0;
    end
    else if(~mode)
    begin
        if(cand1_vote_valid)
            cand1_vote_recvd = cand1_vote_recvd + 1;
        else if(cand2_vote_valid)
            cand2_vote_recvd = cand2_vote_recvd + 1;
        else if(cand3_vote_valid)
            cand3_vote_recvd = cand3_vote_recvd + 1;
    end
end


endmodule
