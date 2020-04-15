## Frequently Asked Questions

#### What should happen if an invalid file path is given? Is this also a "ParsingError"?

You can assume that the commands will always be given with the correct file path and that you can read its content.
There is no need to check that the file path given in input is a valid file path pointing to a readable file.

#### From which player's perspective should the final state be presented? Always player A, or from the perspective of the next player to make a move?

From the player making the next move.

#### From the project description, I assume that the coordinates given in a move are always from the perspective of the current player. Is that correct?

Yes.

#### When a player has won should the final state be presented from this player's perspective?

After the winning move of the player the final state is presented from the prospective of the opponent.

#### Is the game invalid if there are more moves in the input file after the winning move?

Yes.

#### Should the other player's pieces always be represented with the empty list, even though the winning player has won by the "Way of the Stream"?

Yes.

#### Is a game valid if the file contains whitespace followed by a valid game?

Yes. That is OK.

#### Is a game valid if its initial start state is a valid middle-game state? For instance, can a player start with less than 5 pieces?

Yes.


