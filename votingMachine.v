`timescale 1ns / 1ps

module votingMachine(
  input clock,
  input reset,
  input mode,
  input button1,
  input button2,
  input button3,
  input pollsig,
  input [7:0] voter_id,
  output already_voted,
  output pollsigON,
  output decimal_point0,
  output decimal_point1,
  output [6:0] digit0,
  output [6:0] digit1
);

  assign decimal_point0 = 1;
  assign decimal_point1 = 1;

  wire valid_vote_1;
  wire valid_vote_2;
  wire valid_vote_3;
  wire [6:0] cand1_vote_recvd;
  wire [6:0] cand2_vote_recvd;
  wire [6:0] cand3_vote_recvd;
  wire [255:0] voted;
  wire anyValidVote;
  
  wire reset_n;
  wire mode_n;
  wire button1_n;
  wire button2_n;
  wire button3_n;
  wire pollsig_n;
  wire [7:0] voter_id_n;
  
  assign reset_n = ~reset;
  assign mode_n = ~mode;
  assign button1_n = ~button1;
  assign button2_n = ~button2;
  assign button3_n = ~button3;
  assign pollsig_n = ~pollsig;
  assign voter_id_n = ~voter_id;  

  assign pollsigON = ~(pollsig_n & mode);
  assign already_voted = ~(voted[voter_id_n] & mode);
  assign anyValidVote = valid_vote_1 | valid_vote_2 | valid_vote_3 ;
  
  buttonControl bc1(
    .clock(clock),
    .reset(reset_n),
    .button(button1_n),
    .mode(mode_n),
    .pollsig(pollsig_n),
    .voter_id(voter_id_n),
    .voted(voted),
    .valid_vote(valid_vote_1)
  );

  buttonControl bc2(
    .clock(clock),
    .reset(reset_n),
    .button(button2_n),
    .mode(mode_n),
    .pollsig(pollsig_n),
    .voter_id(voter_id_n),
    .voted(voted),
    .valid_vote(valid_vote_2)
  );

  buttonControl bc3(
    .clock(clock),
    .reset(reset_n),
    .button(button3_n),    
    .mode(mode_n),
    .pollsig(pollsig_n),
    .voter_id(voter_id_n),
    .voted(voted),
    .valid_vote(valid_vote_3)
  );
  
  authentication auth(
    .clock(clock),
    .reset(reset_n),
    .anyValidVote(anyValidVote),
    .voter_id(voter_id_n),
	.voted(voted)
  ); 
  
  voteLogger VL(
    .clock(clock),
    .reset(reset_n),
    .mode(mode_n),
    .cand1_vote_valid(valid_vote_1),
    .cand2_vote_valid(valid_vote_2),
    .cand3_vote_valid(valid_vote_3),
    .cand1_vote_recvd(cand1_vote_recvd),
    .cand2_vote_recvd(cand2_vote_recvd),
    .cand3_vote_recvd(cand3_vote_recvd)
  );

  modeControl MC(
    .clock(clock),
    .reset(reset_n),
    .mode(mode_n),
    .valid_vote_casted(anyValidVote),
    .candidate1_vote(cand1_vote_recvd),
    .candidate2_vote(cand2_vote_recvd),
    .candidate3_vote(cand3_vote_recvd),
    .candidate1_button_press(button1_n),
    .candidate2_button_press(button2_n),
    .candidate3_button_press(button3_n),
    .digit0(digit0),
    .digit1(digit1)
  );

endmodule
