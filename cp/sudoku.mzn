include "globals.mzn";

array[1..9,1..9] of var 1..9: cell;

constraint
    forall(i in 1..9)( alldifferent(j in 1..9)( cell[i,j] )) /\
    forall(j in 1..9)( alldifferent(i in 1..9)( cell[i,j] )) /\
    forall(i,j in 1..3)
        ( alldifferent(p,q in 1..3)( cell[3*(i-1)+p, 3*(j-1)+q] ));

solve satisfy;

output [ show(cell[i,j]) ++ if j = 9 then "\n" else "," endif | i,j in 1..9 ];

cell=[|
_, 7, _, _, _, _, _, _, _|
_, _, 8, 4, _, 1, _, 7, _|
_, _, _, _, 8, 5, _, 3, _|
_, 2, 6, 8, _, 9, _, 4, _|
_, _, 7, _, _, _, 9, _, _|
_, 5, _, 1, _, 6, 3, 2, _|
_, 4, _, 6, 1, _, _, _, _|
_, 3, _, 2, _, 7, 6, 9, _|
_, _, _, _, _, _, _, _, _|
|];
