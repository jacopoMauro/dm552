% 
% There is a number of obj to carry by a group of people that need to be
% distributed equally among the people (i.e., distribute the obj such that
% the difference in mass is minimized).

% There are four people and 20 obj. The obj are 23, 43, 
% 12, 54, 7, 3, 5, 10, 54, 55, 26, 9, 9, 43, 54, 1, 8, 6, 38, 33 
% respectively.  What distribution of the 20 obj gives the smallest 
% mass difference between the four people?
% 
% With MIP solvers this can be solved fast. Not so fast with other solvers!
%
include "globals.mzn";

int: num_people = 4;
int: num_obj = 20;

array[1..num_obj] of int: weight_obj =
    [23, 43,  12, 54, 7, 3, 5, 10, 54, 55, 26, 9, 9, 43, 54, 1, 8, 6, 38, 33];

int: max_weight = sum(weight_obj) div num_people + max(weight_obj) + 1;

array[1..num_obj,1..num_people] of var 0..1: matrix_obj_people;

array[1..num_people] of var 0..max_weight: weight_knapsack;

var 0..max(weight_obj): max_diff;

% all objects are picked up by one person only
constraint
	forall(i in 1..num_obj)(
			sum(j in 1..num_people)(matrix_obj_people[i,j]) = 1
	);

% compute the weight of every knapsack
constraint
   forall(p in 1..num_people) (
      weight_knapsack[p] = sum(o in 1..num_obj)(weight_obj[o]*matrix_obj_people[o,p])
   );

% symmetry breaking & useful also for the object function
constraint
  decreasing(weight_knapsack);

solve minimize weight_knapsack[1]-weight_knapsack[num_people];

output [ "assignment: \n"] ++
   [ show(matrix_obj_people[i,j]) ++ if i = num_obj then "\n" else "," endif | j in 1..num_people, i in 1..num_obj ] ++
 	 ["maximal difference:" ++ show(weight_knapsack[1]-weight_knapsack[num_people]) ++ "\n"];


