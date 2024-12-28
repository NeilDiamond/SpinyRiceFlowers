rrgen <- function(mm, n=10, threshold=10^{-5}){
  mmm <- mm
  replicate(n, mysample(mm = mmm, threshold = threshold))
}
