import scala.annotation.tailrec

object Sorts{


///////////////////////////////////////////////////////
// Destructive quick sort algorithm.                 //
// Implements Lomuto partition scheme for quicksort. //
///////////////////////////////////////////////////////

  def quicksort[A] (xs: Array[A])(implicit ord: Ordering[A]): Array[A] = {

    def swap(i: Int, j: Int): Unit = {
      val value = xs(i); xs(i) = xs(j); xs(j) = value}

    // partition given array
    def partition(lo:Int, hi:Int):Int = {
      val pivot = xs(hi)
      var cur = lo
      for (i<-lo to (hi-1)){
        if (ord.lteq(xs(i),pivot)) {
          swap(i,cur)
          cur += 1
        }
      }
      swap(cur,hi)
      cur
    }

    def _quicksort(lo: Int, hi: Int):Array[A] ={
      if (lo< hi){
        val p = partition(lo, hi)
        _quicksort(lo,p-1)
        _quicksort(p+1,hi)
      } else xs
    }
    // call quicksort function
    _quicksort(0, xs.length-1)
  }



/////////////////////////////////////////////////////
// Destructive quick sort algorithm.               //
// Implements Hoare partition scheme for quicksort //
/////////////////////////////////////////////////////

  def quicksort2[A] (xs: Array[A])(implicit ord: Ordering[A]): Array[A] = {

    def swap(i: Int, j: Int): Unit = {
      val value = xs(i); xs(i) = xs(j); xs(j) = value}

    // partition given array
    def partition(l:Int, h:Int):Int = {
      var lo = l
      var hi = h
      val pivot = xs(lo)
      while (lo<hi) {
        while (lo<hi && ord.gteq(xs(hi),pivot)) hi -= 1
        while (lo<hi && ord.lt(xs(lo),pivot)) lo += 1
        if (lo<hi) swap(lo, hi)
      }
      hi
    }
    def _quicksort(lo: Int, hi: Int):Array[A] ={
      if (lo< hi){
        val p = partition(lo, hi)
        _quicksort(lo,p)
        _quicksort(p+1,hi)
      }
      xs
    }
    // call quicksort function
    _quicksort(0, xs.length-1)
  }

//////////////////////////
// TopDown merge sort   //
//////////////////////////
  def mergeSort1[A: scala.reflect.ClassTag]
    (xs: Array[A])(implicit ord: Ordering [A]): Array[A] = xs match{
    case Array() => Array()
    case Array(a) => Array(a)
    case _ => {
    def _merge (xs: List[A], ys: List[A]): List[A] = (xs, ys) match {
      case (Nil, ys) => ys
      case (xs, Nil) => xs
      case(x::xs, y::ys) =>
        if(ord.lt(x,y)) x::_merge(xs, y::ys)
        else y::_merge(x::xs, ys)
    }

    val pivot = xs.length/2
    val (firstHalf, secondHalf) = xs.splitAt(pivot)
    _merge(mergeSort1(firstHalf).toList, mergeSort1(secondHalf).toList).toArray[A]
  }
}

//////////////////////////
// Bottom up merge sort //
//////////////////////////
  def mergeSort2 [A: scala.reflect.ClassTag]
    (a: Array[A])(implicit ord: Ordering [A]): Array[A] = {

    def _merge (xs: List[A], ys: List[A]): List[A] = (xs, ys) match {
      case (Nil, ys) => ys
      case (xs, Nil) => xs
      case(x::xs, y::ys) =>
        if(ord.lt(x,y)) x::_merge(xs, y::ys)
        else y::_merge(x::xs, ys)
    }

    def mergeMap[B](f:(B, B)=> B)(ls: List[B]):List[B] = ls match {
      case Nil => Nil
      case List(a) => List(a)
      case a::b::abs => f(a, b) :: mergeMap(f)(abs)
    }

    def _sort(ls: List[List[A]]): List[List[A]] = ls match {
      case Nil => List(Nil)
      case List(xs) => List(xs)
      case xss => _sort(mergeMap(_merge)(xss))
    }

    _sort(a.toList.map(x=> List(x))).head.toArray
  }

}
