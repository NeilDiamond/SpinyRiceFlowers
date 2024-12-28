#' Plot Heat Map
#'
#' @param xy Data Frame to use
#' @param xrange Limits of the x-variable
#' @param yrange Limits of the y-variable
#' @param gridsep Separation of dotted lines
#'
#' @return a ggplot2 object
#' @export
#'
#' @examples
#' HeatMap(Site29[,2:3], weights=Site29$NUMPimelea,xrange=c(11,25), yrange=c(0,11), gridsep=5, title="Heat Map of Site 29")
HeatMap <- function(xy, weights=rep(1,nrow(xy)),
                    xrange=c(0,35),
                    yrange=c(0,15), gridsep=5,
                    title="Heat Map of Location"){
  w <- as.numeric(weights)/sum(as.numeric(weights))*nrow(xy)
  colnames(xy) <- c("x-axis","y-axis")
    fhat <- ks::kde.boundary(as.matrix(xy[,c("x-axis","y-axis")]),
                             w=w,
                           xmin=c(xrange[1],yrange[1]),
                           xmax=c(xrange[2],yrange[2]))
  x <- fhat$eval.points[[1]]
  y <- fhat$eval.points[[2]]
  fdens <- cooltools::approxfun2(x, y, fhat$estimate)
  mygrid <- expand.grid(x=seq(xrange[1],xrange[2], length.out=100),
                        y=seq(yrange[1],yrange[2], length.out=100))
  mygrid$dens=fdens(mygrid$x, mygrid$y)
  mydata <- data.frame(xx=xy[,"x-axis"],
                       yy=xy[,"y-axis"],
                       ww=weights)
  colnames(mydata) <- c("xx","yy","ww")

  ggplot2::ggplot(mygrid, aes(x, y)) +
    geom_raster(aes(fill=dens)) +
    scale_x_continuous(NULL, expand = c(0, 0)) +
    scale_y_continuous(NULL, expand = c(0, 0)) +
    theme(legend.position = "none")+
    scale_fill_gradientn(colours=hcl.colors(9, "YlOrRd", rev = TRUE))+
geom_vline(xintercept=seq(xrange[1],xrange[2],gridsep), linetype=2)+
geom_hline(yintercept=seq(yrange[1],yrange[2],gridsep), linetype=2)+
    labs(x="",y="")+
    ggtitle(title)+
    geom_hdr_lines_fun(fun=fdens, xlim=xrange, ylim=yrange,
                       probs=seq(0.1, 0.9,0.1),
                       show.legend = TRUE, linewidth=0.5)+
    geom_point(data=mydata, aes(x=xx,y=yy,fill=NULL), size=1.5*sqrt(mydata$ww), colour=4)
}


