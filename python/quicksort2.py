"""
Destructive quick sort algorithm.
Implements Hoare partition scheme for quicksort"""
import unittest
from hypothesis import given
from hypothesis import Settings
# from hypothesis import Verbosity
from hypothesis.strategies import integers
from hypothesis.strategies import lists
from hypothesis.strategies import text


def _quick_sort(ls, lo, hi):
    if lo < hi:
        pivot = partition(ls, lo, hi)
        _quick_sort(ls, lo, pivot)
        _quick_sort(ls, pivot+1, hi)
    return ls


def partition(ls, lo, hi):
    pivot = ls[lo]
    i = lo
    j = hi
    while True:
        while i < j and (ls[j] >= pivot):
            j -= 1
        while i < j and (ls[i] < pivot):
            i += 1
        if i < j:
            (ls[i], ls[j]) = (ls[j], ls[i])
        else:
            return i


def quick_sort(ls):
    return _quick_sort(ls, 0, len(ls)-1)


class SortTestCase(unittest.TestCase):

    @given(lists(elements=integers()),
           settings=Settings(max_examples=500))
    def test_int_sort(self, ls):
        self.assertListEqual(quick_sort(ls[:]), sorted(ls))

    #  verbosity=Verbosity.verbose)
    @given(lists(elements=text()),
           settings=Settings(max_examples=500))
    def test_text_sort(self, ls):
        self.assertListEqual(quick_sort(ls[:]), sorted(ls))

if __name__ == '__main__':
    unittest.main()
