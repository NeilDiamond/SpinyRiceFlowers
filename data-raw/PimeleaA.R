## code to prepare `PimeleaA` dataset goes here

PimeleaA <- read_xlsx("./inst/extdata/PimeleaA.xlsx")[,c(1:6,9:10)]
colnames(PimeleaA)[1] <- "Tag ID"
PimeleaA <- PimeleaA[(PimeleaA$`Status 2017`=="Existing"|
                        PimeleaA$`Status 2017`=="Germinant" )|
                     (is.na(PimeleaA$`Status 2017`)),]
PimeleaA <- PimeleaA[!is.na(PimeleaA$`Tag ID`),]

attr(PimeleaA, "Length") <- "6 m."
attr(PimeleaA, "Width") <- "9 m."
attr(PimeleaA, "Area") <- "54 sq m."

usethis::use_data(PimeleaA, overwrite = TRUE)
