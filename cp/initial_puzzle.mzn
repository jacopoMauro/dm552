include "globals.mzn";

array[1..8] of var 1..8: nodes;

array[1..8] of set of int: edges = [
  {2,3,4}, % 1 node
  {1,3,5,6}, %2 node
  {1,2,4,5,6,7}, %3 node
  {1,3,6,7}, %4 node
  {2,3,6,8}, %5 node
  {2,3,4,5,7,8}, %6 node
  {3,4,6,8}, %7 node
  {5,6,7} %8 node
];

constraint
  alldifferent(nodes) /\
  forall(i in 1..8)(
    forall(j in edges[i])(
      abs(nodes[i] - nodes[j]) > 1
    )
  );
  
solve satisfy;

output [ "nodes: " ++ show(nodes)]
 