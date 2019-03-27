import Game

main = do
  play (return initGame)

play :: IO Game.Game -> IO Game.Game
play ig = do
  g <- ig
  print g
  s <- getLine
  play (return $ nextAction g s)


