## code to prepare `BonThomasAIncProbsMat` dataset goes here

ff <- ks::kde.boundary(AllPlantsby2020[,2:3],
                       xmin=c(0,0),xmax=c(35,15))
BonThomasAQuadratProbs <- quadratprobs(ff, quadratstart=c(0,0),
                                       quadratsize=5)
BonThomasAIncProbsMat <- inclusionprobs(BonThomasAQuadratProbs)

BonThomasAIncProbsMat <- purrr::map_df(1:nrow(BonThomasAIncProbsMat),
              function(i)
                table(BonThomasAIncProbsMat[1:i,])/
                ncol(BonThomasAIncProbsMat))
BonThomasAIncProbsMat <- BonThomasAIncProbsMat[,as.character(1:21)]
BonThomasAIncProbsMat <- as.data.frame(BonThomasAIncProbsMat )
BonThomasAIncProbsMat[is.na(BonThomasAIncProbsMat)] <- 0

usethis::use_data(BonThomasAIncProbsMat, overwrite = TRUE)
