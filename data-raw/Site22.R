## code to prepare `Site22` dataset goes here


Site22 <- read.csv("./inst/extdata/Site_22_WGS84_convert_UTM.csv")
Site22 <- data.frame(Tag_ID=1:nrow(Site22), x.axis=Site22[,"east"],
y.axis=Site22[,"north"])
Site22$x.axis <- Site22$x.axis-min(Site22$x.axis)
Site22$y.axis <- Site22$y.axis-min(Site22$y.axis)
colnames(Site22) <- c("Tag ID", "x-axis", "y-axis")

usethis::use_data(Site22, overwrite = TRUE)

plot(Site22[,2:3])
apply(Site22,2, range)

#Site_22_Hands_Rd_Pimelea_count <- readxl::read_excel("./inst/extdata/Site 22 Hands Rd Pimelea count.xlsx")
#Site22 <- Site_22_Hands_Rd_Pimelea_count
#rangex <- range(c(Site22$left))
#rangey <- range(c(Site22$bottom))
#ite22$NUMPimela[Site22$NUMPimelea==0] <- 0.0001
#Site22$x <- Site22$left+0.5-rangex[1]
#Site22$y <- Site22$bottom+0.5-rangey[1]
#Site22 <- Site22[,c("id_2","x","y","NUMPimelea")]
#Site22 <- Site22[Site22$NUMPimelea>0,]






