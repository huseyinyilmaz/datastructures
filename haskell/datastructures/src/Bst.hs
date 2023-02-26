module Bst (push, contains, wrap, Tree (..)) where

import Control.Monad
import Test.QuickCheck

import System.Random(Random)

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Functor, Foldable, Traversable, Show, Eq)

instance Ord a => Semigroup (Tree a) where
  -- (<>) :: Tree a -> Tree a -> Tree a
  (<>) Empty treeb = treeb
  (<>) treea treeb = foldl push treeb treea

instance Ord a => Monoid (Tree a) where
  mempty = Empty

instance (Ord a, Arbitrary a, Num a, Random a) => Arbitrary (Tree a) where
  arbitrary = gen 0 100
    where
      gen :: (Ord a, Num a, Random a) => a -> a -> Gen (Tree a)
      gen minVal maxVal
        | maxVal - minVal < 3 = return Empty
        | otherwise = do
            val <- choose (minVal, maxVal)
            liftM3 Node (gen minVal (val - 1)) (return val) (gen (val + 1) maxVal)

toList 
instance Eq a => Eq (Tree a) where
  eq a b = 


push :: Ord a => Tree a -> a -> Tree a
push Empty a = Node Empty a Empty
push (Node left value right) a
  | value < a = Node left value (push right a)
  | otherwise = Node (push left a) value right

contains :: Ord a => Tree a -> a -> Bool
contains Empty _ = False
contains (Node left value right) a
  | a == value = True
  | a < value = contains right a
  | otherwise = contains left a

wrap :: a -> Tree a
wrap a = Node Empty a Empty
