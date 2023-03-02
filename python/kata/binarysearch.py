import unittest
from hypothesis import given
from hypothesis import settings
from hypothesis.strategies import lists
from hypothesis.strategies import integers


def binary_search(
    ns: list[int], target: int, start_idx: int = 0, end_idx: int | None = None
) -> int | None:
    if end_idx is None:
        end_idx = len(ns)
    # Implement binary_search

    middle_idx = (start_idx + end_idx) // 2

    if middle_idx == start_idx:
        return None

    middle = ns[middle_idx]

    if middle == target:
        return middle_idx
    elif middle < target:
        return binary_search(ns, target, middle_idx, end_idx)
    elif middle > target:
        return binary_search(ns, target, start_idx, middle_idx)


class BinarySearchTests(unittest.TestCase):
    @given(lists(elements=integers()))
    @settings(max_examples=500)
    def test_search_test(self, ls: list[int]):
        ls.sort()
        expected = 0
        result = binary_search(ls, ls[expected] if ls else 0)
        if ls and result is not None:
            self.assertEqual(ls[result], ls[expected])
        else:
            self.assertIsNone(result)


if __name__ == "__main__":
    unittest.main()
