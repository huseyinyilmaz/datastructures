module Sorting where
import qualified Data.List as List
--import qualified Data.Vector as Vector
quicksort1 :: Ord a => [a] -> [a]
quicksort1 [] = []
quicksort1 (a:as) = quicksort1 smaller ++ a:quicksort1 larger
  where (smaller, larger) = List.partition (<a) as


-- quicksort2 as = Vector.toList $ sort vec 0 (Vector.length vec - 1)
--   where
--     vec = Vector.fromList as
--     --sort :: Vector.Vector a -> Int -> Int -> Vector.Vector a
--     sort v lo hi | lo < hi = let pivot = partition v lo hi
--                                  v1 = sort v lo (pivot-1)
--                                  v2 = sort v1 (pivot+1) hi in v2
--                  | otherwise = v

--     partition v lo hi = foldl [lo..hi]
--       updateList i current
--       where pivot = v Vector.! p


--top down merge sort
-- split the list in half
-- sort two parts with same algorithm
-- merge two parts
mergesort :: Ord a => [a] -> [a]
mergesort [] = []
mergesort [a] = [a]
mergesort l = merge (mergesort as) (mergesort bs)
  where halve [] = ([], [])
        halve [x] = ([x], [])
        halve (x:y:xys) = (x:xs, y:ys)
          where (xs, ys) = halve(xys)
        (as, bs) = halve l
        merge [] ys = ys
        merge xs [] = xs
        merge (x:xs) (y:ys) | x < y = x:merge xs (y:ys)
                            | otherwise = y:merge (x:xs) ys


-- Bottom up merge sort.
-- Convert all elements to singleton lists.
-- Merge every two elements until we left with one.
mergesort2 :: Ord a => [a] -> [a]
mergesort2 as = case (mergesort2' . (map (\a->[a]))) as of
  [] -> []
  (x:_) -> x


mergesort2' :: Ord a => [[a]] -> [[a]]
mergesort2' [] = []
mergesort2' [as] = [as]
mergesort2' (as:bs:css) = mergesort2' $ (merge as bs) : (mergesort2' css)
  where merge :: Ord a => [a] -> [a] -> [a]
        merge [] ys = ys
        merge xs [] = xs
        merge (x:xs) (y:ys) | x < y = x:(merge xs (y:ys))
                            | otherwise = y:(merge (x:xs) ys)
