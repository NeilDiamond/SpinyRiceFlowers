## code to prepare `PimeleaC` dataset goes here
PimeleaC <- read_xlsx("./inst/extdata/PimeleaC.xlsx")[,1:8]
PimeleaC$`x-axis` <- PimeleaC$`x-axis` + 4
PimeleaC$`y-axis` <- PimeleaC$`y-axis` + 2
colnames(PimeleaC)[1] <- "Tag ID"
PimeleaC <- PimeleaC[(PimeleaC$`Status 2017`=="Existing"|
                        PimeleaC$`Status 2017`=="Germinant" )|
                       (is.na(PimeleaC$`Status 2017`)),]
PimeleaC <- PimeleaC[!is.na(PimeleaC$`Tag ID`),]

attr(PimeleaC, "Length") <- "10 m."
attr(PimeleaC, "Width") <- "14 m."
attr(PimeleaC, "Area") <- "140 sq m."

usethis::use_data(PimeleaC, overwrite = TRUE)
