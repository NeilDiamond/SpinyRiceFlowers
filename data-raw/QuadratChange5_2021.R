## code to prepare `QuadratChange5_2021` dataset goes here

qx5Died2021 <- quadratcount(
  spatstat.geom::ppp(
    unlist(BonThomasADied2021[, 2]),
    unlist(BonThomasADied2021[, 3]),
    window = spatstat.geom::owin(xrange = c(0, 35),
                                 yrange = c(0, 15))),
  xbreaks = seq(0, 35, 5),
  ybreaks = seq(0, 15, 5)
)

qx5Recruit2021 <- quadratcount(
  spatstat.geom::ppp(
    unlist(BonThomasARecruit2021[, 2]),
    unlist(BonThomasARecruit2021[, 3]),
    window = spatstat.geom::owin(xrange = c(0, 35),
                                 yrange = c(0, 15))),
  xbreaks = seq(0, 35, 5),
  ybreaks = seq(0, 15, 5)
)

QuadratChange5_2021 <- qx5Recruit2021-qx5Died2021
usethis::use_data(QuadratChange5_2021, overwrite = TRUE)
