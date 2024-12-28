## code to prepare `DentonAveA` dataset goes here

DentonAveA <- read_xlsx("./inst/extdata/DentonAveA.xlsx")[,c(2:7,9:10)]
colnames(DentonAveA)[c(1,7,8)] <- c("Tag ID","x-axis","y-axis")
DentonAveA <- DentonAveA[(DentonAveA$`Status 2017`=="Existing"|
                            DentonAveA$`Status 2017`=="Germinant" )|
                           (is.na(DentonAveA$`Status 2017`)),]
DentonAveA <- DentonAveA[!is.na(DentonAveA$`Tag ID`),]

attr(DentonAveA, "Length") <- "22 m."
attr(DentonAveA, "Width") <- "24 m."
attr(DentonAveA, "Area") <- "528 sq m."

usethis::use_data(DentonAveA, overwrite = TRUE)
