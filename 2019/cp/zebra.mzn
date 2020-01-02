% This is a puzzle which has been circulating the net. There are a couple
% different versions out there which try to be a little more politically
% correct but are essentially the same problem.    
% 	1. There are five houses, each of a different color and inhabited by
%	   men of different nationalities, with different pets, drinks,
%	   and cigarettes.
% 	2. The Englishman lives in the red house.
% 	3. The Spaniard owns the dog.
% 	4. Coffee is drunk in the green house.
% 	5. The Ukrainian drinks tea.
% 	6. The green house is immediately to the right of the ivory house.
% 	7. The Old Gold smoker owns snails.
% 	8. Kools are smoked in the yellow house.
% 	9. Milk is drunk in the middle house.
% 	10. The Norwegian lives in the first house on the left.
% 	11. The man who smokes Chesterfields lives in the house next to the
%	    man with the fox.
% 	12. Kools are smoked in the house next to the house where the horse is
%	    kept.
% 	13. The Lucky Strike smoker drinks orange juice.
% 	14. The Japanese smoke Parliaments.
% 	15. The Norwegian lives next to the blue house.
% NOW, who drinks water? And who owns the zebra?

include "globals.mzn";

enum Nationalities = { English, Spanish, Ukrainian, Norwegian, Japanese };
enum Colours = { Red, Green, Ivory, Yellow, Blue };
enum Animals = { Dog, Fox, Horse, Zebra, Snails };
enum Drinks = { Coffee, Tea, Milk, OrangeJuice, Water };
enum Cigarettes = { OldGold, Kools, Chesterfields, LuckyStrike, Parliaments };

set of int: Houses = 1..5;

array[index_set(Nationalities)] of var Houses: nation;
array[index_set(Colours)] of var Houses: colour;
array[index_set(Animals)] of var Houses: animal;
array[index_set(Drinks)] of var Houses: drink;
array[index_set(Cigarettes)] of var Houses: smoke;

predicate nextto(var Houses:h1, var Houses:h2) = 
       h1 = h2 + 1 \/ h2 = h1 + 1;

predicate rightof(var Houses:h1, var Houses:h2) =
       h1 = h2 + 1;

function int: middleHouse() = 3;

function int: leftHouse() = 1;

constraint
	alldifferent(nation) /\
	alldifferent(colour) /\
	alldifferent(animal) /\
	alldifferent(drink) /\
	alldifferent(smoke) /\
 	nation[English] = colour[Red] /\
	nation[Spanish] = animal[Dog] /\
	drink[Coffee] = colour[Green] /\
  nation[Ukrainian] = drink[Tea] /\
  colour[Green] `rightof` colour[Ivory] /\
  smoke[OldGold] = animal[Snails] /\
  smoke[Kools] = colour[Yellow] /\
  drink[Milk] = middleHouse() /\
  nation[Norwegian] = leftHouse() /\
  smoke[Chesterfields] `nextto` animal[Fox] /\
  smoke[Kools] `nextto` animal[Horse] /\
  smoke[LuckyStrike] = drink[OrangeJuice] /\
  nation[Japanese] = smoke[Parliaments] /\
  nation[Norwegian] `nextto` colour[Blue];

solve satisfy;

array[int] of string: str_Nationalities = [ "English", "Spanish", "Ukrainian", "Norwegian", "Japanese"];
array[int] of string: str_Colours = [ "Red", "Green", "Ivory", "Yellow", "Blue" ];
array[int] of string: str_Animals = [ "Dog", "Fox", "Horse", "Zebra", "Snails" ];
array[int] of string: str_Drinks = [ "Coffee", "Tea", "Milk", "OrangeJuice", "Water" ];
array[int] of string: str_Cigarettes = [ "OldGold", "Kools", "Chesterfields", "LuckyStrike", "Parliaments" ];

output [
  "House, Nation, Colour, Animal, Drink, Smoke)\n"] ++ 
[ show(i) ++ ","  ++
  show([str_Nationalities[j] | j in index_set(nation) where nation[j] == i][1]) ++ "," ++
  show([str_Colours[j] | j in index_set(colour) where nation[j] == i][1]) ++ "," ++
  show([str_Animals[j] | j in index_set(animal) where nation[j] == i][1]) ++ "," ++
  show([str_Drinks[j] | j in index_set(drink) where nation[j] == i][1]) ++ "," ++
  show([str_Cigarettes[j] | j in index_set(smoke) where nation[j] == i][1]) ++ "\n"
  | i in Houses
];