import org.scalatest._
import Sorts.quicksort
import Sorts.quicksort2

class QuickSortSpec extends FlatSpec with Matchers {

  "quicksort" should "sort integer arrays" in {
      quicksort(Array(3,1,2)) should be (Array(1,2,3))
      quicksort(Array(0, 1, -1)) should be (Array(-1, 0, 1))
  }

  it should "sort boolean arrays" in {
    quicksort(Array(false, true, false)) should be (Array(false, false, true))
    quicksort(Array(true, false, true)) should be (Array(false, true, true))
}
}

class QuickSort2Spec extends FlatSpec with Matchers {

  "quicksort2" should "sort integer arrays" in {
      quicksort2(Array(3,1,2)) should be (Array(1,2,3))
      quicksort2(Array(0, 1, -1)) should be (Array(-1, 0, 1))
  }

  it should "sort boolean arrays" in {
    quicksort2(Array(false, true, false)) should be (Array(false, false, true))
    quicksort2(Array(true, false, true)) should be (Array(false, true, true))
}
}
