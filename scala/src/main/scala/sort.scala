object Sorts{

  def quicksort[A] (xs: List[A]): List[A] = {

    def partition(lo:Int, hi:Int):Int = {


    }

    def _quicksort(lo: Int, hi: Int):List[A] =
      if (lo<hi){
        val p = partition(lo, hi)
        _quicksort(lo,p-1)
        _quicksort(p+1,hi)
      } else xs



    _quicksort(0, xs.length)

  }

}
