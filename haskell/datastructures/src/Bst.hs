module Bst (push, contains, makeTree, Tree (..)) where

import Control.Monad
import System.Random (Random)
import Test.QuickCheck

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Functor, Foldable, Traversable, Show)

instance Ord a => Semigroup (Tree a) where
  -- (<>) :: Tree a -> Tree a -> Tree a
  (<>) Empty treeb = treeb
  (<>) treea treeb = foldl push treeb treea

instance Ord a => Monoid (Tree a) where
  mempty = Empty

instance (Arbitrary a, Random a, Ord a, Num a) => Arbitrary (Tree a) where
  arbitrary = gen 0 100
    where
      gen :: (Arbitrary a, Random a, Ord a, Num a) => a -> a -> Gen (Tree a)
      gen minVal maxVal
        | maxVal - minVal < 3 = return Empty
        | otherwise = do
            val <- choose (minVal, maxVal)
            liftM3 Node (gen minVal (val - 1)) (return val) (gen (val + 1) maxVal)

toList :: Tree a -> [a]
toList Empty = []
toList (Node left val right) = toList left ++ [val] ++ toList right

instance Eq a => Eq (Tree a) where
  (==) a b = toList a == toList b

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

makeTree :: a -> Tree a
makeTree a = Node Empty a Empty
