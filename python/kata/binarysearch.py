from typing import List
from typing import Optional
import unittest
from hypothesis import given
from hypothesis import settings
from hypothesis.strategies import lists
from hypothesis.strategies import integers


def binary_search(
    ns: List[int], target: int, start_idx: int = 0, end_idx: int | None = None
) -> Optional[int]:
    if end_idx is None:
        end_idx = len(ns)
    # Implement binary_search
    return start_idx


class BinarySearchTests(unittest.TestCase):
    @given(lists(elements=integers()))
    @settings(max_examples=500)
    def test_search_test(self, ls: List[int]):
        ls.sort()
        expected = 0
        result = binary_search(ls, ls[expected] if ls else 0)
        if ls and result:
            self.assertEqual(ls[result], ls[expected])
        else:
            self.assertIsNone(result)


if __name__ == "__main__":
    unittest.main()
