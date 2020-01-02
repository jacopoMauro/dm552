






-- "Helper" file, that was used in class to try out how Data.Array works.

import Data.Array

makeSquareMx :: Int -> Array (Int,Int) Bool
makeSquareMx a = array ((1,1),(a,a)) [((x,y), False) | x <- [1..a], y <- [1..a]]

change :: Array (Int,Int) Bool -> (Int,Int) -> Bool -> Array (Int, Int) Bool
change arr (x,y) tf = arr//[((x,y), tf), ((1,1),True)]
