module Main where

import Data.List(sort)
import Test.QuickCheck

import qualified Sorting as Sorting

newtype SmallInt = SmallInt Int deriving (Eq,Show)

instance Arbitrary SmallInt where
  arbitrary = do val <- choose (1, 999)
                 return $ SmallInt val


prop_int_sort_quickcheck1 :: [Int] -> Bool
prop_int_sort_quickcheck1 is = sort is == Sorting.quicksort1 is

prop_str_sort_quickcheck1 :: [String] -> Bool
prop_str_sort_quickcheck1 is = sort is == Sorting.quicksort1 is

main :: IO()
main = do quickCheck prop_int_sort_quickcheck1
          quickCheck prop_str_sort_quickcheck1
