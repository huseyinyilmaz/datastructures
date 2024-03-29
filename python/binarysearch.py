import unittest
from hypothesis import given
from hypothesis import settings
from hypothesis.strategies import lists
from hypothesis.strategies import integers


def binary_search(
    ns: list[int], target: int, start_idx: int = 0, end_idx: int | None = None
) -> int | None:
    if not ns:
        return None
    if end_idx is None:
        end_idx = len(ns)
    mid_idx = (start_idx + end_idx) // 2
    mid = ns[mid_idx]
    if mid == target:
        return mid_idx
    elif start_idx == mid_idx:
        return None
    elif mid < target:
        return binary_search(ns, target, mid_idx, end_idx)
    elif mid > target:
        return binary_search(ns, target, start_idx, mid_idx)


class BinarySearchTests(unittest.TestCase):
    @given(lists(elements=integers()))
    @settings(max_examples=500)
    def test_search_test(self, ls: list[int]):
        print(ls)
        ls.sort()
        expected = 0
        result = binary_search(ls, ls[expected] if ls else 0)
        if ls:
            self.assertIsNotNone(result)
            if result is not None:
                self.assertEqual(ls[result], ls[expected])
        else:
            self.assertIsNone(result)


if __name__ == "__main__":
    unittest.main()
