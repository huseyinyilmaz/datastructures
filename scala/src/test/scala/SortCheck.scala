import org.scalacheck.Properties
import org.scalacheck.Prop.forAll
import Sorts.quicksort

object QuickSortSpecification extends Properties("Sort.quicksort") {

  property("sorted") = forAll { (ls: List[Int]) =>
    ls.sorted == quicksort(ls)
  }
}
