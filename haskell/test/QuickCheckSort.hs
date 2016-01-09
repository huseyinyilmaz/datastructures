import Data.List(sort)
import Test.QuickCheck

import qualified Quicksort1 as Quicksort1
import qualified Quicksort2 as Quicksort2

newtype SmallInt = SmallInt Int deriving (Eq,Show)

instance Arbitrary SmallInt where
  arbitrary = do val <- choose (1, 999)
                 return $ SmallInt val


prop_int_sort_quickcheck1 :: [Int] -> Bool
prop_int_sort_quickcheck1 is = sort is == Quicksort1.quicksort is

prop_str_sort_quickcheck1 :: [String] -> Bool
prop_str_sort_quickcheck1 is = sort is == Quicksort1.quicksort is

prop_int_sort_quickcheck2 :: [Int] -> Bool
prop_int_sort_quickcheck2 is = sort is == Quicksort2.quicksort is

prop_str_sort_quickcheck2 :: [String] -> Bool
prop_str_sort_quickcheck2 is = sort is == Quicksort2.quicksort is

main :: IO()
main = do quickCheck prop_int_sort_quickcheck1
          quickCheck prop_str_sort_quickcheck1
          quickCheck prop_int_sort_quickcheck2
          quickCheck prop_str_sort_quickcheck2
