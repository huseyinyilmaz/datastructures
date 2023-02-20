"""
https://users.monash.edu/~lloyd/tildeAlgDS/Sort/Flag/
"""
from typing import List
import unittest
from hypothesis import given
from hypothesis import settings
from hypothesis.strategies import lists
from hypothesis.strategies import integers


def dnf(l: List[int]) -> int:
    """
    l = has values 0, 1 and 2
    [0:low_idx+1] has values 0
    [low_idx+1: mid_idx+1] has values 1
    [mid_idx+1, high_idx+1] unknown
    [high_idx+1:] has values 2
    """
    low_idx = 0
    mid_idx = 0
    high_idx = len(l) - 1
    # stop when mid pointer is larger than high pointer
    while mid_idx <= high_idx:
        mid = l[mid_idx]
        # if mid pointer has low value switch it with low pointer and increase bothself.
        # this works because low pointer guaranteed to have mid value under it.
        # (except if it is first element)
        if mid == 0:
            l[mid_idx], l[low_idx] = l[low_idx], l[mid_idx]
            low_idx += 1
            mid_idx += 1
        # if mid pointer has mid value, location is correct just move the pointer.
        elif mid == 1:
            mid_idx += 1
        # if mid pointer has high value, switch them and decrease high pointer. we do not
        # increase mid pointer because we don't know what high pointer had under it.
        # we will check it on next iteration.
        elif mid == 2:
            l[mid_idx], l[high_idx] = l[high_idx], l[mid_idx]
            high_idx -= 1
    # return low pointer (first medium element)
    # and mid pointer (first high element)
    return (low_idx, mid_idx)


class DNFTests(unittest.TestCase):
    @given(lists(elements=integers(0, 2)))
    @settings(max_examples=500)
    def testNormalEntry(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)

    @given(lists(elements=integers(0, 0)))
    @settings(max_examples=500)
    def testOnlyLow(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)

    @given(lists(elements=integers(1, 1)))
    @settings(max_examples=500)
    def testOnlyMediums(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)

    @given(lists(elements=integers(2, 2)))
    @settings(max_examples=500)
    def testOnlyHighs(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)

    @given(lists(elements=integers(0, 1)))
    @settings(max_examples=500)
    def testOnlyLowandMed(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)

    @given(lists(elements=integers(1, 2)))
    @settings(max_examples=500)
    def testOnlyMedandHigh(self, l: List[int]):
        result = sorted(l)
        dnf(l)
        self.assertListEqual(result, l)


if __name__ == "__main__":
    unittest.main()
