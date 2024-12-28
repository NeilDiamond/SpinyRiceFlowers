## code to prepare `PimeleaD` dataset goes here

PimeleaD <- read_xlsx("./inst/extdata/PimeleaD.xlsx")[,c(1:6,11:12)]

colnames(PimeleaD)[c(1,7:8)] <- c("Tag ID","x-axis","y-axis")
PimeleaD <- PimeleaD[(PimeleaD$`Status 2017`=="Existing"|
                        PimeleaD$`Status 2017`=="Germinant" )|
                       (is.na(PimeleaD$`Status 2017`)),]
PimeleaD <- PimeleaD[!is.na(PimeleaD$`Tag ID`),]

attr(PimeleaD, "Length") <- "26 m."
attr(PimeleaD, "Width") <- "18 m."
attr(PimeleaD, "Area") <- "468 sq m."

usethis::use_data(PimeleaD, overwrite = TRUE)
