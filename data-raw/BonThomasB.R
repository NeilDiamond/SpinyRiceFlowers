## code to prepare `BonThomasB` dataset goes here

BonThomasB <- read_xlsx("./inst/extdata/BonThomasB.xlsx")[,2:9]
colnames(BonThomasB)[1] <- "Tag ID"
BonThomasB <- BonThomasB[(BonThomasB$`Status 2017`=="Alive"|
                            BonThomasB$`Status 2017`=="Germinant" )|
                           (is.na(BonThomasB$`Status 2017`)),]
BonThomasB <- BonThomasB[!is.na(BonThomasB$`Tag ID`),]

attr(BonThomasB, "Length") <- "15 m."
attr(BonThomasB, "Width") <- "12 m."
attr(BonThomasB, "Area") <- "180 sq m."


usethis::use_data(BonThomasB, overwrite = TRUE)
