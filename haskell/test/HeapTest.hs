import Test.QuickCheck
import Heap as Heap

instance Arbitrary a => Arbitrary Heap a where
    arbitrary = sized arbTree

arbTree :: Int -> Gen a
arbTree 0 = Node <$> arbitrary <$> (return [])
arbTree n = do
  (Positive m) <- arbitrary
  let n' = n / (m + 1)
  f <- replicateM m (arbTree n')
  a <- arbitrary
  return $ Node a f
