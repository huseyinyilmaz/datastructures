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
mergesort2' ass = mergesort2' $ unzipmap merge ass
  where unzipmap :: (a -> a -> a) -> [a] -> [a]
        unzipmap _ [] = []
        unzipmap _ [a] = [a]
        unzipmap f (a:b:cs) = f a b : unzipmap f cs
        merge :: Ord a => [a] -> [a] -> [a]
        merge [] ys = ys
        merge xs [] = xs
        merge (x:xs) (y:ys) | x < y = x:(merge xs (y:ys))
                            | otherwise = y:(merge (x:xs) ys)

--top down merge sort
-- split the list in half
-- sort two parts with same algorithm
-- merge two parts
-- Source: https://www.reddit.com/r/haskell/comments/40v6wo/merge_sort_complexity_problem/cyy5b7t
mergesort3 :: Ord a => [a] -> [a]
mergesort3 [] = []
mergesort3 [a] = [a]
mergesort3 l = merge (mergesort3 as) (mergesort3 bs)
  where (as, bs) = split2 l
        -- | @halfsies@ picks out every 2nd element of a list, starting with the first
        --   one. The resulting list is of course half as long as the original one.
        --   Example: halfsies [1..10] = [1,3,5,7,9]
        --            halfsies [2..10] = [2,4,6,8]
        halfsies :: [a] -> [a]
        halfsies (x:_:xs) = x : halfsies xs
        halfsies _       = []

        -- | @end xs ys@ drops one element from xs for every element of ys. The result
        --   is equivalent to @drop (length ys) xs@ for finite lists, but `end` also
        --   works on infinite lists.
        end :: [a] -> [b] -> [a]
        end    xs     []  = xs
        end    []      _ = []
        end (_:xs) (_:ys) = end xs ys

        -- | Splits a lift in halves of equal (+-1) length.
        split2 :: [a] -> ([a], [a])
        split2 xs = (firstHalf, secondHalf)
          where h          = halfsies xs
                firstHalf  = zipWith const xs h
                secondHalf = end xs h

        merge [] ys = ys
        merge xs [] = xs
        merge (x:xs) (y:ys) | x < y = x:merge xs (y:ys)
                            | otherwise = y:merge (x:xs) ys
