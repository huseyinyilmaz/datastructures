module Main where

import qualified Sorting as Sorting
import qualified Data.List as List
import Criterion.Main

main :: IO ()
main = defaultMain [
  -- bgroup "quickSort1" [ bench "1000"    $ whnf Sorting.quicksort1 ([1000, 999..1]::[Int]),
  --                       bench "10000"   $ whnf Sorting.quicksort1 ([10000, 9999..1]::[Int]),
  --                       bench "100000"  $ whnf Sorting.quicksort1 ([100000, 99999..1]::[Int])],
  bgroup "Data.List.Sort" [ bench "1000"    $ whnf List.sort ([1000, 999..1]::[Int]),
                            bench "10000"   $ whnf List.sort ([10000, 9999..1]::[Int]),
                            bench "100000"  $ whnf List.sort ([100000, 99999..1]::[Int])],
  bgroup "mergeSort1" [ bench "1000"    $ whnf Sorting.mergesort  ([1000, 999..1]::[Int]),
                        bench "10000"   $ whnf Sorting.mergesort  ([10000, 9999..1]::[Int]),
                        bench "100000"  $ whnf Sorting.mergesort  ([100000, 99999..1]::[Int])],
  bgroup "mergeSort2" [ bench "1000"    $ whnf Sorting.mergesort2 ([1000, 999..1]::[Int])
                      , bench "10000"   $ whnf Sorting.mergesort2 ([10000, 9999..1]::[Int])
                      , bench "100000"  $ whnf Sorting.mergesort2 ([100000, 99999..1]::[Int])],
  bgroup "mergeSort3" [ bench "1000"    $ whnf Sorting.mergesort3 ([1000, 999..1]::[Int])
                      , bench "10000"   $ whnf Sorting.mergesort3 ([10000, 9999..1]::[Int])
                      , bench "100000"  $ whnf Sorting.mergesort3 ([100000, 99999..1]::[Int])]

  ]
