module Main where

import Data.List(sort)
import Test.QuickCheck

import qualified Sorting as Sorting

newtype SmallInt = SmallInt Int deriving (Eq,Show)

instance Arbitrary SmallInt where
  arbitrary = do val <- choose (1, 999)
                 return $ SmallInt val


prop_int_sort_quicksort :: [Int] -> Bool
prop_int_sort_quicksort is = sort is == Sorting.quicksort1 is

prop_str_sort_quicksort :: [String] -> Bool
prop_str_sort_quicksort is = sort is == Sorting.quicksort1 is

prop_int_sort_mergesort :: [Int] -> Bool
prop_int_sort_mergesort is = sort is == Sorting.mergesort is

prop_str_sort_mergesort :: [String] -> Bool
prop_str_sort_mergesort is = sort is == Sorting.mergesort is

prop_int_sort_mergesort2 :: [Int] -> Bool
prop_int_sort_mergesort2 is = sort is == Sorting.mergesort2 is

prop_str_sort_mergesort2 :: [String] -> Bool
prop_str_sort_mergesort2 is = sort is == Sorting.mergesort2 is

main :: IO()
main = do quickCheck prop_int_sort_quicksort
          quickCheck prop_str_sort_quicksort
          quickCheck prop_str_sort_mergesort
          quickCheck prop_str_sort_mergesort
          quickCheck prop_str_sort_mergesort2
          quickCheck prop_str_sort_mergesort2
