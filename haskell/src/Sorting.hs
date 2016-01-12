module Sorting where
import qualified Data.List as List
import qualified Data.Vector as Vector
quicksort1 :: Ord a => [a] -> [a]
quicksort1 [] = []
quicksort1 (a:as) = quicksort1 smaller ++ a:quicksort1 larger
  where (smaller, larger) = List.partition (>a) as


quicksort2 as = Vector.toList $ sort vec 0 (Vector.length vec - 1)
  where
    vec = Vector.fromList as
    --sort :: Vector.Vector a -> Int -> Int -> Vector.Vector a
    sort v lo hi | lo < hi = let pivot = partition v lo hi
                                 v1 = sort v lo (pivot-1)
                                 v2 = sort v1 (pivot+1) hi in v2
                 | otherwise = v

    partition v lo hi = foldl [lo..hi]
      updateList i current
      where pivot = v Vector.! p
