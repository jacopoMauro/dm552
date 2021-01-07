% There are a limited number of players and a limited number of tennis courts. At each 
% round, there can be at most as many matches as there are courts. Nobody plays 2 rounds without a 
% break. Everyone plays a match against everyone else. Produce the schedule that takes as few 
% rounds as possible. (Because of the rule that there must a break between rounds for everyone, 
% there can be a round without matches.) 

include "globals.mzn"; 

int: n; % number of players
int: num_courts; % number of courts

%
% data

n = 9; % more than 30 minutes
%n = 8;
num_courts = 3;

int: m = n*(n-1) div 2; % number of matches
array[1..m] of int: first_player = [i | i,j in 1..n where i < j];
array[1..m] of int: second_player = [j | i,j in 1..n where i < j];
int: bound_rounds = m*2;

% decision variables
array[1..m] of var 1..bound_rounds: map_match_round;
array[1..bound_rounds] of var 0..num_courts: used_courts;

% no more matches than the number of courts
constraint
  forall(i in 1..bound_rounds)(
    count(map_match_round,i,used_courts[i])
  );

% no two matches played in a row by a player
constraint
  forall(p in 1..n)(
    forall(i,j in 1..m where
          i<j /\
          (first_player[i] == p \/ second_player[i] == p) /\
          (first_player[j] == p \/ second_player[j] == p))(
     map_match_round[i] + 1 != map_match_round[j] /\
     map_match_round[i] - 1 != map_match_round[j] /\
     map_match_round[i] != map_match_round[j]
    )
  );

% symmetry breaking constraints
% first player's game are sorted
constraint
  increasing([ map_match_round[i] | i in 1..m where first_player[i] == 1 \/ second_player[i] == 1]);

% first match is decided to be played at round 1
constraint
  map_match_round[1]=1;
  
% second player plays agains third one after the first one
% strangely this constraints makes the performance worse when n = 8
%constraint
%   increasing([ map_match_round[i] | i in 1..m where (first_player[i] < 3) /\ second_player[i] == 3]);

% all courts used in the first round if enough players
% imagine that in the first round a court can not be used and there are num_courts*2
% if there is a pair playing in the second round, that match can be anticipated.
% Then no games are in the second round.
% If there are num_courts*2 than at least a match can be anticipated.
constraint
  if n >= num_courts*2 then
    used_courts[1] = num_courts
  else
    true
  endif;

solve minimize max(map_match_round);

output 
[
  "matches (player,player,round):\n"
] ++
[ "\t(" ++ show(first_player[i]) ++ "," ++ show(second_player[i]) ++ "," ++ show(map_match_round[i]) ++ ")\n" | i in 1..m] ++
[ "max_round: " ++ show(max(map_match_round)) ++ "\n"];
