module BstTest(main) where
import Test.QuickCheck
import Data.List(sort)

import qualified Bst

prop_int_binary_search_tree_built_correctly :: [Int] -> Bool
prop_int_binary_search_tree_built_correctly is = sort is == js
  where tree = mconcat (fmap Bst.wrap is)
        js = foldr (:) [] tree

prop_str_binary_search_tree_built_correctly :: [String] -> Bool
prop_str_binary_search_tree_built_correctly is = sort is == js
  where tree = mconcat (fmap Bst.wrap is)
        js = foldr (:) [] tree

prop_int_binary_search_tree_monoid :: [Int] -> [Int] -> Bool
prop_int_binary_search_tree_monoid is js = sort (is ++ js) == ks
  where itree = mconcat (fmap Bst.wrap is)
        jtree = mconcat (fmap Bst.wrap js)
        tree = itree <> jtree
        ks = foldr (:) [] tree
main :: IO ()
main = do
  quickCheck prop_int_binary_search_tree_built_correctly
  quickCheck prop_str_binary_search_tree_built_correctly
  quickCheck prop_int_binary_search_tree_monoid
