#' calculate
#'
#' @param xs x-coordinates of the data
#' @param ys y-coordinates of the data
#' @param xbr quadrat x-breaks
#' @param ybr quadrat y-breaks
#'
#' @return matrix of quadrat probabilitiesx
#' @export
#'
#' @examples
#'
#' x <- AllPlantsby2020[,"x-axis"]
#' y <- AllPlantsby2020[,"y-axis"]
#' quadprob(x,y)
#'
quadprob <- function(xs=xx, ys=yy, xbr=seq(0,35,5), ybr=seq(0,15,5)){
  hx <- MASS::bandwidth.nrd(xs)/4
  hy <- MASS::bandwidth.nrd(ys)/4
  gridvals <- expand.grid(xbr, ybr)
  probvals <- purrr:::map2_dbl(gridvals[,1], gridvals[,2], kdedist2d_1, xs=xs, ys=ys, hx=hx, hy=hy)
  #print(cbind(gridvals,probvals))
  matvals <- matrix(probvals, nrow=length(ybr), byrow=T)
  mm2 <- matvals
  matvals1 <<- matvals
  #print(mm2)
  #mm <- mm2[-length(ybr),-1]+mm2[-1,-length(xbr)]-mm2[-length(ybr),-length(xbr)]-mm2[-1,-1]
  mm <- mm2[-1,-1, drop=FALSE]+mm2[-length(ybr),-length(xbr), drop=FALSE]-mm2[-length(ybr),-1, drop=FALSE]-mm2[-1,-length(xbr),drop=FALSE]
  if(!is.null(dim(mm))){
    mm <- mm[nrow(mm):1,]
  }

  return(mm/sum(mm))
}
