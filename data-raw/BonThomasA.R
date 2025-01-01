## code to prepare `BonThomasA` dataset goes here

BonThomasA <- readxl::read_excel("./inst/extdata/BonThomasA.xlsx")[,1:8]
colnames(BonThomasA)[c(1,7:8)] <- c("Tag ID","x-axis","y-axis")
BonThomasA <- BonThomasA[(BonThomasA$`Status 2017`=="Existing"|
                            BonThomasA$`Status 2017`=="Germinant" )|
                           (is.na(BonThomasA$`Status 2017`)),]
BonThomasA <- BonThomasA[!is.na(BonThomasA$`Tag ID`),]
attr(BonThomasA, "Length") <- "35 m."
attr(BonThomasA, "Width") <- "15 m."
attr(BonThomasA, "Area") <- "525 sq m."

usethis::use_data(BonThomasA, overwrite = TRUE)
