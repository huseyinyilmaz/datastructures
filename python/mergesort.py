"""
Destructive merge sort algorithm.
Implements top down scheme
"""
import unittest
from hypothesis import given
from hypothesis import settings
# from hypothesis import Verbosity
from hypothesis.strategies import integers
from hypothesis.strategies import lists
from hypothesis.strategies import text


def merge(xs, ys):
    """Merge 2 lists into one"""
    result = []
    # create iterator to go over both lists
    xi = iter(xs)
    yi = iter(ys)
    x = next(xi, None)
    y = next(yi, None)
    while x is not None and y is not None:
        if x < y:
            result.append(x)
            x = next(xi, None)
        else:
            result.append(y)
            y = next(yi, None)
    # put left over element back to list
    result.append(x if y is None else y)
    # find out which list is longer
    rest_iter = xi if y is None else yi
    result.extend(rest_iter)
    return result


def merge_sort(xs):
    """
    Topdown merge sort implementation
    """
    l = len(xs)
    if l <= 1:
        response = xs
    else:
        i = l//2
        response = merge(merge_sort(xs[:i]), merge_sort(xs[i:]))
    return response


def _merge_sort2(xss):
    if len(xss) == 1:
        return xss
    else:
        result = []
        ys = None
        for xs in xss:
            if ys is None:
                ys = xs
            else:
                result.append(merge(xs, ys))
                ys = None
        # Add left over element into result
        if ys is not None:
            result.append(ys)
        return _merge_sort2(result)


def merge_sort2(xs):
    """
    Bottom up merge sort implementation
    """
    if xs:
        response = _merge_sort2([[x] for x in xs])[0]
    else:
        response = xs
    return response


class SortTestCase(unittest.TestCase):

    @given(lists(elements=integers()))
    @settings(max_examples=500)
    def test_int_sort(self, ls):
        self.assertListEqual(merge_sort(ls[:]), sorted(ls))

    #  verbosity=Verbosity.verbose)
    @given(lists(elements=text()))
    @settings(max_examples=500)
    def test_text_sort(self, ls):
        self.assertListEqual(merge_sort(ls[:]), sorted(ls))


class Sort2TestCase(unittest.TestCase):

    @given(lists(elements=integers()))
    @settings(max_examples=500)
    def test_int_sort(self, ls):
        self.assertListEqual(merge_sort2(ls[:]), sorted(ls))

    #  verbosity=Verbosity.verbose)
    @given(lists(elements=text()))
    @settings(max_examples=500)
    def test_text_sort(self, ls):
        self.assertListEqual(merge_sort2(ls[:]), sorted(ls))

if __name__ == '__main__':
    unittest.main()
