kdedist2d_1 <- function(x,y, xs=xx, ys=yy, hx=4.17, hy=1.08){
  sum(exp((pnorm((x-xs)/hx, log.p=TRUE) + pnorm((y-ys)/hy, log.p=TRUE) )))/length(xs)}
