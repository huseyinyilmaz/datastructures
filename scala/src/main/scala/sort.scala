object Sorts{

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



}
