## code to prepare `Site29` dataset goes here


Site29 <- readxl::read_excel("./inst/extdata/Site 29 Jasper Road Patch220 count.xlsx")

rangex <- range(c(Site29$left))
rangey <- range(c(Site29$bottom))
#ite22$NUMPimela[Site22$NUMPimelea==0] <- 0.0001
Site29$x <- Site29$left+0.5-rangex[1]
Site29$y <- Site29$bottom+0.5-rangey[1]
Site29 <- Site29[,c("id_2","x","y","NUMPimelea")]
Site29 <- Site29[Site29$NUMPimelea>0,]





usethis::use_data(Site29, overwrite = TRUE)
