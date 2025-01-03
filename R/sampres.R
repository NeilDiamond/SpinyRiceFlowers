#' Quadrat Probabilities
#'
#' @param quadratsize Size of quadrat ib m.
#' @param xmax Maximum x co-ordinate
#' @param ymax Maximum y co-ordinate
#' @param Allplants Locations of Plants
#' @param xxmin Minimum of x and y
#' @param xxmax Maximum of x and y
#'
#' @return  Estimated quadrat  probability
#' @export
#'
#' @examples sampres(5, Allplants = AllPlantsby2020[,c(2,3)])
#'

sampres <- function(quadratsize, xmax=35, ymax=15, Allplants=AllPlantsby2020[,2:3],
                    xxmin=c(0,0), xxmax=c(35,15)){


  fhat <- ks::kde.boundary(Allplants, xmin=xxmin, xmax=xxmax)
  C <- matrixStats::colCumsums(matrixStats::rowCumsums(fhat$estimate))
  C <- C/max(C)
  x <- fhat$eval.points[[1]]
  y <- fhat$eval.points[[2]]
  fdens <- cooltools::approxfun2(x, y, fhat$estimate)
  f <- cooltools::approxfun2(x, y, C)
  f1 <- function(xy){
      f(xy[1],xy[2])
  }
  gr <- expand.grid(x=seq(0,xmax,quadratsize), y=seq(0,ymax, quadratsize))
  grd <- cbind(gr[,1], gr[,2], apply(gr, 1, f1))
  startquadrats <- function(quadratsize, xlim=c(0,xmax), ylim=c(0,ymax)){
    xleftover <- xlim[2]-floor(diff(xlim)/quadratsize)*quadratsize
    yleftover <- ylim[2]-floor(diff(ylim)/quadratsize)*quadratsize
    c(xleftover, yleftover)
  }
  max_x <- grd[nrow(grd),1]; max_y <- grd[nrow(grd),2]
  maxstart <- startquadrats(quadratsize)

  gxy <- function(xy, f2=f1){
    x <- xy[1]
    y <- xy[2]
    f2(c(x+max_x, y+max_y))+f2(c(x, y))-f2(c(x+max_x,y))-f2(c(x,y+max_y))
  }
  gx <- function(x, f2=f1){
    f2(c(x+max_x, max_y))+f2(c(x, 0))-f2(c(x+max_x,0))-f2(c(x,max_y))
  }
  gy <- function(y, f2=f1){
    f2(c(max_x, y+max_y))+f2(c(0, y))-f2(c(max_x,y))-f2(c(0,y+max_y))
  }
  if(maxstart[1]==0 & maxstart[2]==0){startvals <- c(0,0)} else
    if(maxstart[1]!=0 & maxstart[2]==0){

      startvals <- c(optim(0, gx, lower=0, upper=maxstart[1], method="L-BFGS-B",         control=list(fnscale=-1))$par,0)} else
        if(maxstart[1]==0 & maxstart[2]!=0){
          startvals <- c(0,optim(0, gy, lower=0, upper=maxstart[2], method="L-BFGS-B", control=list(fnscale=-1))$par)} else
          {startvals <- optim(c(0,0), gxy, lower=c(0,0), upper=maxstart, method="L-BFGS-B", control=list(fnscale=-1))$par}

  gr <- expand.grid(x=startvals[1]+seq(0,xmax,quadratsize), y=startvals[2]+seq(0,ymax,quadratsize))

  d1 <- diff(apply(gr, 1, f1))


  m1 <- matrix(c(d1,0), ncol=1+floor(xmax/quadratsize), byrow=T)
  m2 <- apply(m1[,-ncol(m1)],2, diff)
  m2 <- m2[nrow(m2):1,]

  xbr <- seq(0,xmax,quadratsize)
  ybr <- seq(0,ymax,quadratsize)
  qx <- spatstat.geom::quadratcount(spatstat.geom::as.ppp(cbind(Allplants[,1],
                                             Allplants[,2]),
                                       W=c(range(xbr),
                                           range(ybr))),
                                xbreaks=unique(xbr),
                                ybreaks=unique(ybr))
  row.names(m2) <- row.names(qx)
  colnames(m2) <- colnames(qx)

  return(m2)

}



