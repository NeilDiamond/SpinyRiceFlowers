## code to prepare `PimeleaF` dataset goes here

PimeleaF <- read_xlsx("./inst/extdata/PimeleaF.xlsx")[,c(2:7,9:10)]

colnames(PimeleaF)[c(1,7:8)] <- c("Tag ID","x-axis","y-axis")

PimeleaF <- PimeleaF[(PimeleaF$`Status 2017`=="Existing"|
                        PimeleaF$`Status 2017`=="Germinant" )|
                       (is.na(PimeleaF$`Status 2017`)),]
PimeleaF <- PimeleaF[!is.na(PimeleaF$`Tag ID`),]

attr(PimeleaF, "Length") <- "14 m."
attr(PimeleaF, "Width") <- "8 m."
attr(PimeleaF, "Area") <- "112 sq m."

usethis::use_data(PimeleaF, overwrite = TRUE)
