import org.scalacheck.Properties
import org.scalacheck.Prop.forAll
import Sorts.quicksort
import Sorts.quicksort2
import Sorts.mergeSort1
import Sorts.mergeSort2

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


object MergeSort1Specification extends Properties("Sort.mergeSort1") {

  property("Can sort Array[Int]") = forAll { (a: Seq[Int]) => {
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort1(is).sameElements(js)
  }
  }

  property("Can sort Array[String]") = forAll { (a: Seq[String]) =>
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort1(is).sameElements(js)
  }

  property("Can sort Array[Boolean]") = forAll { (a: Seq[Boolean]) =>
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort1(is).sameElements(js)
  }

}

object MergeSort2Specification extends Properties("Sort.mergeSort2") {

  property("Can sort Array[Int]") = forAll { (a: Seq[Int]) => {
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort2(is).sameElements(js)
  }
  }

  property("Can sort Array[String]") = forAll { (a: Seq[String]) =>
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort2(is).sameElements(js)
  }

  property("Can sort Array[Boolean]") = forAll { (a: Seq[Boolean]) =>
    val is = a.toArray
    val js = is.clone.sorted
    mergeSort2(is).sameElements(js)
  }

}
