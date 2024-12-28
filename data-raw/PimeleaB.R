## code to prepare `PimeleaB` dataset goes here

PimeleaB <- read_xlsx("./inst/extdata/PimeleaB.xlsx")[,c(1:6,10:11)]
PimeleaB$`x-axis` <- PimeleaB$`x-axis` + 1
PimeleaB$`y-axis` <- PimeleaB$`y-axis` + 1
colnames(PimeleaB)[1] <- "Tag ID"
PimeleaB <- PimeleaB[(PimeleaB$`Status 2017`=="Existing"|
                        PimeleaB$`Status 2017`=="Germinant" )|
                       (is.na(PimeleaB$`Status 2017`)),]
PimeleaB <- PimeleaB[!is.na(PimeleaB$`Tag ID`),]

attr(PimeleaB, "Length") <- "6 m."
attr(PimeleaB, "Width") <- "4 m."
attr(PimeleaB, "Area") <- "24 sq m."

usethis::use_data(PimeleaB, overwrite = TRUE)
