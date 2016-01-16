module Heap where

import Data.List(mapAccumL)
import Data.List(iterate)
import Control.Monad(ap)
data Heap a = Empty | Node{heapLeft::(Heap a), heapValue::a, heapSize::Int, heapRight::(Heap a)} deriving (Show)

instance Functor Heap where
  fmap _ Empty = Empty
  fmap f (Node l a s r) = Node (fmap f l) (f a) s (fmap f r)

instance Monoid Heap where
  mempty =
  mappend =

instance Foldable Heap where
  foldMap _ Empty = mempty
  foldMap f (Node l a _ r) = (foldMap f l) `mappend` (f a) `mappend` (foldMap f r)

instance Applicative Heap where
  pure = return
  (<*>) = ap

instance Monad Heap where
  return a =  Node Empty a 1 Empty
  h >>= f = foldr (mappend) Empty (fmap f h)
heap :: Heap a
heap = Empty

heapLength :: Heap b -> Int
heapLength h = foldr (\_ agg -> agg+1) 0 h

-- [(<number of children in each level of tree>, <number of maximum elements in tree>)]
--[(1,1),(2,3),(4,7),(8,15),(16,31),(32,63),(64,127),(128,255),(256,511),(512,1023)
getLevelCounts :: [(Int, Int)]
getLevelCounts = zip latestTreeLevelCount totalLength
  where
    latestTreeLevelCount = iterate (*2) 1
    totalLength = scanl1 (+) latestTreeLevelCount


insert :: Ord a => Heap a -> a -> Heap a
insert Empty a = Node Empty a 1 Empty
insert (Node l a' s r) a
  | heapSize l <= heapSize r = Node (insert l childVal) currentVal newSize r
  | otherwise = Node l currentVal newSize (insert l childVal)
  where currentVal = max a a'
        childVal = min a a'
        newSize = s + 1
