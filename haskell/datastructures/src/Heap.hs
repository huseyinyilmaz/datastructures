module Heap (newHeap, Heap(..)) where

data Heap a where
  Empty :: Heap a
  Node :: {getLeft::Heap a, getVal:: a, getRight::Heap a, getMinDepth:: Int} -> Heap a
  deriving (Functor, Foldable, Traversable, Show)

newHeap :: a -> Heap a
newHeap a = Node Empty a Empty 1

add :: Ord a => Heap a -> a -> Heap a
add Empty a = newHeap a
add (Node left val right _) a
  | getMinDepth right > getMinDepth left = Node left val (add right a)
  | otherwise = right                                 

