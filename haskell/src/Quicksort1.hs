module Quicksort1 where

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (a:as) = quicksort smaller ++ [a] ++ quicksort larger
  where smaller = [a' | a' <- as, a >= a']
        larger = [a' | a' <- as, a < a']
