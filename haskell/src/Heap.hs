module Heap where

data Heap a = Empty | Node{heapLeft::(Heap a), heapValue::a, heapRight::(Heap a)} deriving (Show)

instance Functor Heap where
  fmap _ Empty = Empty
  fmap f (Node l a r) = Node (fmap f l) (f a) (fmap f r)

instance Foldable Heap where
  foldMap _ Empty = mempty
  foldMap f (Node l a r) = (foldMap f l) `mappend` (f a) `mappend` (foldMap f r)

heap :: Heap a
heap = Empty

heapLength :: Heap b -> Int
heapLength h = foldr (\_ agg -> agg+1) 0 h

full :: Heap a -> Bool
full Empty = True
full (Node l@(Node _ _ _) _ r@(Node _ _ _)) = full l && full r && length l == length r
full _ = False

insert :: Ord a => Heap a -> a -> Heap a
insert Empty a = Node Empty a Empty
insert (Node l a' r) a
  | ((full l) && (full r) && (heapLength l == heapLength r)) || not (full l) = Node (insert l childVal) currentVal r
  | otherwise = Node l currentVal (insert r childVal)
  where currentVal = max a a'
        childVal = min a a'
