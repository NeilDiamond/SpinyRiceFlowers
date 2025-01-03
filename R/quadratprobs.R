#' Title Calculate Quadrat Probability
#'
#' @param plantlocations x and y coordinates
#' @param quadratstart lower left co-ordinates ofthe first quadrat
#' @param quadratsize width (and length) of the quadrats
#' @param xmin vector of grid minima
#' @param xmax vector of grid maxima
#'
#' @return matrix of quadrat probabilities
#' @export
#'
#' @examples
#'
#' quadratprobs(AllPlantsby2020[,2:3], quadratstart=c(0,0),quadratsize=5,xmin=c(0,0),xmax=c(35,15))
#'
quadratprobs <- function(plantlocations,
                         quadratstart=c(0,0),
                         quadratsize=5,
                         xmin=c(0,0),
                         xmax=c(35,15)){
  if(length(quadratstart)==1){
    if(quadratstart=="calc"){
    quadratstart=startgrid(quadratsize, plantlocations)
    }
  }
  kdeobject <- ks::kde.boundary(plantlocations,
     xmin=xmin,xmax=xmax)
  rangex <- range(kdeobject$eval.points[[1]])
  rangey <- range(kdeobject$eval.points[[2]])
  xseq <- seq(rangex[1]+quadratstart[1], rangex[2], quadratsize)
  yseq <- seq(rangey[1]+quadratstart[2], rangey[2], quadratsize)
  xseq1 <- xseq; yseq1<- yseq
  xseq <- xseq[-1]
  yseq <- yseq[-1]
  quantilegrid <- expand.grid(xseq, yseq)
  approxfun2 = function(x,y,z,outside=NA) {

    if (is.unsorted(x,strictly=TRUE)) stop('x must be strictly monotonically increasing')
    if (is.unsorted(y,strictly=TRUE)) stop('y must be strictly monotonically increasing')

    nx = length(x)
    ny = length(y)

    if (is.array(z)) {
      if (dim(z)[1]!=nx) stop('z must be an array of dimension (length(x),length(y))')
      if (dim(z)[2]!=ny) stop('z must be an array of dimension (length(x),length(y))')
    } else {
      stop('z must be a 2D array')
    }

    xmin = min(x)
    interval = (max(x)-xmin)*2

    xvect = rep(c(-1e-5,x-xmin,max(x)-xmin+1e-5),ny+2)+rep(seq(ny+2)*interval,each=nx+2)
    zvect = as.vector(cbind(rep(Inf,nx+2),rbind(rep(Inf,ny),z,rep(Inf,ny)),rep(Inf,nx+2)))

    fun = approxfun(xvect,zvect,yleft=outside,yright=outside)

    index = approxfun(y,seq(2,ny+1),yleft=1,yright=ny+2)

    fout = function(x,y) {
      f = index(y)
      i = floor(f)
      j = ceiling(f)
      w = f-i
      x1 = (x-xmin)+i*interval
      x2 = (x-xmin)+j*interval
      out = (1-w)*fun(x1)+w*fun(x2)
      out[!is.finite(out)] = outside
      return(out)
    }

    return(fout)
  }
  ff2 <- approxfun2(kdeobject$eval.points[[1]],
                    kdeobject$eval.points[[2]],
                    (kdeobject$estimate))
  myintegral <- function(x,y,quadratsize1=quadratsize){
    if(x==0|y==0){return(0)} else{
      i <- calculus::integral(ff2, bounds = list(x = c(x-quadratsize1,x),y=c(y-quadratsize1,y)),
                    method="pcubature", relTol=0.00001)
      return(i$value)
    }}


  quadprobs <- matrix(purrr::map2_dbl(quantilegrid [,1],quantilegrid [,2],
                              myintegral),
                      byrow=T, ncol=length(xseq))



  colnames(quadprobs) <- paste0("[",xseq1[-length(xseq1)],",",xseq1[-1],")")
  rownames(quadprobs) <- paste0("[",yseq1[-length(yseq1)],",",yseq1[-1],")")

  finaloutput <- quadprobs[nrow(quadprobs):1,]
  attr(finaloutput, "quadratstart") <- quadratstart

  return(finaloutput)
}
