module Bst(push, contains, wrap) where

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Functor, Foldable, Traversable, Show)

instance Ord a => Semigroup (Tree a) where
 -- (<>) :: Tree a -> Tree a -> Tree a
 (<>) Empty treeb = treeb
 (<>) treea treeb = foldl push treeb treea

instance Ord a => Monoid (Tree a) where
  mempty = Empty

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

