-- The simple version of Tic-tac-toe written in class Apr. 1st.
-- Note we did not expose our function in a module, nor make any IO to make it more interactive.

import Data.Array
import Data.Char
import Data.List

-- Typeclass for games, this is not necessary to make Tic work.
class Game g where
  players :: g -> [Player]
  numPlayers :: g -> Int
  numPlayers g = length $ players g


-- The actual tic-tac-toe game object.
data Tic = Tic { board :: Board,
                 player :: Player} deriving ()

-- An alias for working with the board.
type Board = Array (Int,Int) Piece

-- A player type.
data Player = Player1 | Player2 deriving (Eq, Show)

-- The piece type, where None means no piece is in that position.
-- We did this because we wanted a board of pieces.
-- Looking back, I think it would have been nice to refactor this game with the "Maybe Piece" instead.
data Piece = X | O | None deriving ()

initGame :: Tic
initGame = Tic initBoard Player1

initBoard :: Board
initBoard = array ((1,1),(3,3)) [((x,y), None) | x <- [1,2,3], y <- [1,2,3]]

switch :: Player -> Player
switch Player1 = Player2
switch Player2 = Player1

-- The main way to play the game.
-- You give it a game and a position, where the current player is placing their piece,
-- and get back a new game where it's the other players turn and the piece was placed.
place :: Tic -> Int -> Int -> Tic
place (Tic b p) x y = Tic b' p'
  where
    p' = switch p
    b' = b//[((x,y), piece)]
    piece = if p == Player1 then X else O

-- Making a way to visualize the game.
instance Show Tic where
  show (Tic b _) = show' b

-- "Magic" helper function for show Tic.
show' :: Board -> String
show' a = let rows [] = [] ;
              rows ls = (take 3 ls):(rows . drop 3 $ ls) ;
              showRow r = intercalate " | " $ map show r ;
          in intercalate "\n---------\n" $ map showRow (rows . elems $ a)


instance Show Piece where
  show X = "X"
  show O = "O"
  show None = " "

instance Game Tic where
  players _ = [Player1, Player2]

