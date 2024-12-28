## code to prepare `PimeleaE` dataset goes here

PimeleaE <- read_xlsx("./inst/extdata/PimeleaE.xlsx")[,c(2:7,9:10)]

colnames(PimeleaE)[c(1,7:8)] <- c("Tag ID","x-axis","y-axis")
PimeleaE$`x-axis` <- PimeleaE$`x-axis` + 1
PimeleaE <- PimeleaE[(PimeleaE$`Status 2017`=="Existing"|
                        PimeleaE$`Status 2017`=="Germinant" )|
                       (is.na(PimeleaE$`Status 2017`)),]
PimeleaE <- PimeleaE[!is.na(PimeleaE$`Tag ID`),]

attr(PimeleaE, "Length") <- "12 m."
attr(PimeleaE, "Width") <- "20 m."
attr(PimeleaE, "Area") <- "240 sq m."

usethis::use_data(PimeleaE, overwrite = TRUE)
