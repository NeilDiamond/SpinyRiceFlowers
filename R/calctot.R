#' Calculate Total
#'
#' @param ss Sample Size
#' @param probs Quadrat Probabilities
#' @param incprobs Inclusion probabilities
#' @param qx Quadrat Counts
#'
#' @return Estimated Total Number
#' @export
#'
#' @examples
#' \dontrun{
#' ff <- ks::kde.boundary(AllPlantsby2020[,2:3],
#'                     xmin=c(0,0),xmax=c(35,15))
#' probs1 <- quadratprobs(ff, quadratstart=c(0,0),quadratsize=5)
#' results <- table(replicate(100,calctot(15,
#' probs=probs1,
#' incprobs=BonThomasAIncProbsMat[15,],
#' qx=QuadratChange5_2021)))
#' results
#' Hmisc::wtd.mean(as.numeric(names(results)), results)
#' sqrt(Hmisc::wtd.var(as.numeric(names(results)), results))
#' }
calctot <- function(ss, probs, incprobs, qx){
  sval <- wrswoR::sample_int_crank(prod(sapply(attributes(qx)$dimnames,length)),
                                               ss, prob=probs)
  return(sum((as.numeric(qx)/incprobs)[sval]))}
