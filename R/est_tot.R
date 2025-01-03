#' Estimated Total of Plants
#'
#' @param nsamp Number of Samples
#' @param mm Not sure what it is
#' @param qx Quadrat Counts
#' @param rr Output from rrgen
#' @return Coefficient of variation
#' @export
#'
#' @examples
#' \dontrun{
#' est_tot(nsamp=6, mm=mm5, qx=qx5, rr=rr5)
#' }
#'
est_tot <- function(nsamp=6, mm=mm5, qx=qx5, rr=rr5){
  rrsamp <- rr[1:nsamp,]
  incprobs <- tabulate(rrsamp)/ncol(rr)
  mysamp <- matrix(qx[rrsamp], ncol=nsamp, byrow=T)
  myweights <- matrix(incprobs[rrsamp], ncol=nsamp, byrow=T)
  myest <- apply(mysamp/myweights, 1, sum)
  return(round(100*sd(myest, na.rm=T)/mean(myest, na.rm=T),2))
}
