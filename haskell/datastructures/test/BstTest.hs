module BstTest (main) where

import Bst (Tree (..), makeTree)
import Data.List (sort)
import Test.QuickCheck
import Test.QuickCheck.Property.Monoid (T (..), eq, prop_Monoid)

prop_int_binary_search_tree_built_correctly :: [Int] -> Bool
prop_int_binary_search_tree_built_correctly is = sort is == js
  where
    tree = mconcat (fmap makeTree is)
    js = foldr (:) [] tree

prop_str_binary_search_tree_built_correctly :: [String] -> Bool
prop_str_binary_search_tree_built_correctly is = sort is == js
  where
    tree = mconcat (fmap makeTree is)
    js = foldr (:) [] tree

prop_int_binary_search_tree_monoid :: [Int] -> [Int] -> Bool
prop_int_binary_search_tree_monoid is js = sort (is ++ js) == ks
  where
    itree = mconcat (fmap makeTree is)
    jtree = mconcat (fmap makeTree js)
    tree = itree <> jtree
    ks = foldr (:) [] tree

prop_int_binary_search_tree_monoid_2 :: [Int] -> [Int] -> Bool
prop_int_binary_search_tree_monoid_2 is js = sort (is ++ js) == ks
  where
    itree = mconcat (fmap makeTree is)
    jtree = mconcat (fmap makeTree js)
    tree = itree <> jtree
    ks = foldr (:) [] tree

main :: IO ()
main = do
  quickCheck prop_int_binary_search_tree_built_correctly
  quickCheck prop_str_binary_search_tree_built_correctly
  quickCheck prop_int_binary_search_tree_monoid
  quickCheck prop_int_binary_search_tree_monoid_2
  quickCheck $ eq $ prop_Monoid (T :: T (Tree Int))
