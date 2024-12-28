## code to prepare `BonThomasAHeatMap` dataset goes here
fhat <- ks::kde.boundary(AllPlantsby2020[,c("x-axis","y-axis")],
                         xmin=c(0,0), xmax=c(35,15))
x <- fhat$eval.points[[1]]
y <- fhat$eval.points[[2]]
fdens <- cooltools::approxfun2(x, y, fhat$estimate)
mygrid <- expand.grid(x=seq(0,35,length.out=100),
                      y=seq(0,15, length.out=100))
mygrid$dens=fdens(mygrid$x, mygrid$y)
mydata <- data.frame(xx=AllPlantsby2020[,"x-axis"],
                     yy=AllPlantsby2020[,"y-axis"])

BonThomasAHeatMap <- ggplot2::ggplot(mygrid, aes(x, y, fill = dens)) +
  geom_raster() +
  scale_x_continuous(NULL, expand = c(0, 0)) +
  scale_y_continuous(NULL, expand = c(0, 0)) +
  theme(legend.position = "none")+
  scale_fill_gradientn(colours=hcl.colors(9, "YlOrRd", rev = TRUE))+

  geom_vline(xintercept=seq(0,35,5), linetype=2)+
  geom_hline(yintercept=seq(0,15,5), linetype=2)+
  labs(x="",y="")+
  geom_hdr_lines_fun(fun=fdens, xlim=c(0,35), ylim=c(0,15), probs=seq(0.1, 0.9,0.1),
                     show.legend = TRUE, linewidth=0.5)+
  geom_point(data=mydata, aes(x=x.axis,y=y.axis,fill=NULL), size=1.5, colour=4)

usethis::use_data(BonThomasAHeatMap, overwrite = TRUE)
