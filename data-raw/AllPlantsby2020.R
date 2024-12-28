## code to prepare `AllPlantsby2020` dataset goes here


BonThomasA <- read_xlsx("./inst/extdata/BonThomasA.xlsx")[,1:8]
BonThomasA <- BonThomasA[(BonThomasA$`Status 2017`=="Existing"|
                            BonThomasA$`Status 2017`=="Germinant" )|
                           (is.na(BonThomasA$`Status 2017`)),]
BonThomasA <- BonThomasA[!is.na(BonThomasA$`Tag ID`),]

Tags2017 <- BonThomasA[BonThomasA$`Status 2017`=="Existing"&
                       !is.na(BonThomasA$`Status 2017`),"Tag ID"]
Tags2018 <- BonThomasA[BonThomasA$`Status 2018`=="Alive"&
                         !is.na(BonThomasA$`Status 2018`),"Tag ID"]
Tags2019 <- BonThomasA[BonThomasA$`Status 2019`=="Alive"&
                         !is.na(BonThomasA$`Status 2019`),"Tag ID"]
Tags2020 <- BonThomasA[BonThomasA$`Status 2020`=="Alive"&
                         !is.na(BonThomasA$`Status 2020`),"Tag ID"]
TagsIn <- unlist(c(Tags2017, Tags2018, Tags2019,Tags2020))
AllPlantsby2020 <- BonThomasA[BonThomasA$`Tag ID` %in%
                                intersect(BonThomasA$`Tag ID`, TagsIn),
       c("Tag ID", "x-axis position", "y-axis position")]
names(AllPlantsby2020) <- c("Tag ID", "x-axis", "y-axis")
usethis::use_data(AllPlantsby2020, overwrite = TRUE)
