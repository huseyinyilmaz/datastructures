"""
https://users.monash.edu/~lloyd/tildeAlgDS/Sort/Flag/
"""
import unittest
from hypothesis import given
from hypothesis import settings
from hypothesis.strategies import lists
from hypothesis.strategies import integers


def dnf(nums: list[int]) -> tuple[int, int]:
    """
    l = has values 0, 1 and 2
    [0:low_idx+1] has values 0
    [low_idx+1: mid_idx+1] has values 1
    [mid_idx+1, high_idx+1] unknown
    [high_idx+1:] has values 2
    """
    # implement dnf here.
    low_idx = middle_idx = 0
    high_idx = len(nums) - 1

    while middle_idx <= high_idx:
        middle = nums[middle_idx]
        if middle == 0:
            nums[middle_idx], nums[low_idx] = nums[low_idx], nums[middle_idx]
            middle_idx += 1
            low_idx += 1
        elif middle == 1:
            middle_idx += 1
        elif middle == 2:
            nums[middle_idx], nums[high_idx] = nums[high_idx], nums[middle_idx]
            high_idx -= 1
            # return first middle element and first high element indexes.
    return (low_idx, middle_idx)


class DNFTests(unittest.TestCase):
    @given(lists(elements=integers(0, 2)))
    @settings(max_examples=500)
    def testNormalEntry(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)

    @given(lists(elements=integers(0, 0)))
    @settings(max_examples=500)
    def testOnlyLow(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)

    @given(lists(elements=integers(1, 1)))
    @settings(max_examples=500)
    def testOnlyMediums(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)

    @given(lists(elements=integers(2, 2)))
    @settings(max_examples=500)
    def testOnlyHighs(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)

    @given(lists(elements=integers(0, 1)))
    @settings(max_examples=500)
    def testOnlyLowandMed(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)

    @given(lists(elements=integers(1, 2)))
    @settings(max_examples=500)
    def testOnlyMedandHigh(self, nums: list[int]):
        result = sorted(nums)
        dnf(nums)
        self.assertListEqual(result, nums)


if __name__ == "__main__":
    unittest.main()
