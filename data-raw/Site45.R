## code to prepare `Site45` dataset goes here
Site45 <- readxl::read_excel("./inst/extdata/Site 45 Phylands Pimelea count.xlsx")


rangex <- range(c(Site45$left))
rangey <- range(c(Site45$bottom))
Site45$x <- Site45$left+0.5-rangex[1]
Site45$y <- Site45$bottom+0.5-rangey[1]
Site45 <- Site45[,c("id_2","x","y","NUMPimelea")]
Site45 <- Site45[Site45$NUMPimelea>0,]

Site45 <- read.csv("./inst/extdata/Site 45 WGS84 convert UTM.csv")
Site45 <- data.frame(Tag_ID=1:nrow(Site45), x.axis=Site45[,"east"],
                     y.axis=Site45[,"north"])
Site45$x.axis <- Site45$x.axis-min(Site45$x.axis)
Site45$y.axis <- Site45$y.axis-min(Site45$y.axis)
colnames(Site45) <- c("Tag ID", "x-axis", "y-axis")

usethis::use_data(Site45, overwrite = TRUE)

plot(Site45[,2:3])
apply(Site45,2, range)


usethis::use_data(Site45, overwrite = TRUE)
