module Game
  ( Game
  , initGame
  , place
  , move
  , isEnd
  , nextAction
  ) where

import Data.Array
import Data.List

data Game = Game { board :: Board
                 , player :: Player
                 , state :: GameState
                 } deriving ()

data Board = Board { arr :: Array (Int, Int) Piece } deriving ()

data GameState = Place | Move | End deriving (Eq, Show)

data Player = Player1 | Player2 deriving (Eq, Show)

data Piece = X | O | None deriving (Eq)

switch :: Player -> Player
switch Player1 = Player2
switch _       = Player1

playerPiece :: Player -> Piece
playerPiece Player1 = X
playerPiece Player2 = O

initGame :: Game
initGame = Game initBoard Player1 Place

initBoard :: Board
initBoard = Board $ array ((1,1),(3,3)) [((x,y),None) | x <- [1..3], y <- [1..3]]

pieceAt :: Board -> (Int, Int) -> Piece
pieceAt b ix = (arr b)!ix

isEnd :: Game -> Bool
isEnd ( Game _ _ End ) = True
isEnd _ = False

place :: Game -> (Int, Int) -> Game
place (Game b p Place ) ix
  | (pieceAt b ix) == None = (Game b' (switch p) s')
  where
    pp = playerPiece p
    b' = Board $ (arr b)//[(ix, pp)]
    s' = if win p b' then End else if endPlace b' then Move else Place
    endPlace b''
      | placed >= 6 = True
      | otherwise = False
      where
        placed = foldr (\piece acc -> if piece /= None then acc+1 else acc) 0 (arr b'')
place g _ = g -- Not in Place state, return the game unchanged

move :: Game -> (Int, Int) -> (Int, Int) -> Game
move g@(Game b p s ) fromIx toIx
  | illegalMove = g
  | otherwise = Game b' (switch p) s'
  where
    pp = playerPiece p
    illegalMove =
      if s /= Move then
        True
      else if any (not.(flip elem) [1..3]) [fst fromIx, snd fromIx, fst toIx, snd toIx] then
        True
      else if pieceAt b fromIx /= pp || pieceAt b toIx /= None then
        True
      else
        False
    b' = Board $ (arr b)//[(fromIx, None), (toIx, pp)]
    s' = if win p b' then End else s

win :: Player -> Board -> Bool
win p b = winrow || wincol || windiag
  where
    pp = playerPiece p
    winrow = any (snd) [(row, val) | row <- [1..3], let val = all (\col -> (arr b)!(row,col) == pp) [1..3]]
    wincol = any (snd) [(col, val) | col <- [1..3], let val = all (\row -> (arr b)!(row,col) == pp) [1..3]]
    windiag = all (\x -> (arr b)!(x,x) == pp) [1..3] || all (\ix -> (arr b)!ix == pp) [(3,1),(2,2),(1,3)]



nextAction :: Game -> String -> Game
nextAction g@(Game _ _ Place) s = place g (read s::(Int,Int))
nextAction g@(Game _ _ Move) s = move g from to
  where
    ss = words s
    from = read $ ss !! 0 :: (Int,Int)
    to = read $ ss !! 1 :: (Int,Int)

instance Show Game where
  show (Game b _ _) = show b

instance Show Board where
  show (Board a) = let rows [] = [] ;
                       rows ls = (take 3 ls):(rows . drop 3 $ ls) ;
                       showRow r = intercalate " | " $ map show r ;
                   in intercalate "\n---------\n" $ map showRow (rows . elems $ a)

instance Show Piece where
  show X = "X"
  show O = "O"
  show None = " "
