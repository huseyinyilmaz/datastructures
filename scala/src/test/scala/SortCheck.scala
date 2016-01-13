import org.scalacheck.Properties
import org.scalacheck.Prop.forAll
import Sorts.quicksort
import Sorts.quicksort2

object QuickSortSpecification extends Properties("Sort.quicksort") {

  property("Can sort Array[Int]") = forAll { (a: Seq[Int]) => {
    val is = a.toArray
    val js = is.clone.sorted
    quicksort(is)
    js.sameElements(is)
  }
  }

  property("Can sort Array[String]") = forAll { (a: Seq[String]) =>
    val is = a.toArray
    val js = is.clone.sorted
    quicksort(is)
    js.sameElements(is)
  }

  property("Can sort Array[Boolean]") = forAll { (a: Seq[Boolean]) =>
    val is = a.toArray
    val js = is.clone.sorted
    quicksort(is)
    js.sameElements(is)
  }

}

object QuickSort2Specification extends Properties("Sort.quicksort2") {

  property("Can sort Array[Int]") = forAll { (a: Seq[Int]) => {
    val is = a.toArray
    val js = is.clone.sorted
    quicksort2(is)
    js.sameElements(is)
  }
  }

  property("Can sort Array[String]") = forAll { (a: Seq[String]) =>
    val is = a.toArray
    val js = is.clone.sorted
    quicksort2(is)
    js.sameElements(is)
  }

  property("Can sort Array[Boolean]") = forAll { (a: Seq[Boolean]) =>
    val is = a.toArray
    val js = is.clone.sorted
    quicksort2(is)
    js.sameElements(is)
  }

}
