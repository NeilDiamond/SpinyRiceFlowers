## code to prepare `DentonAveB` dataset goes here

DentonAveB <- read_xlsx("./inst/extdata/DentonAveB.xlsx")[,2:9]
colnames(DentonAveB)[c(1,7,8)] <- c("Tag ID","x-axis","y-axis")
DentonAveB <- DentonAveB[(DentonAveB$`Status 2017`=="Existing"|
                            DentonAveB$`Status 2017`=="Germinant" )|
                           (is.na(DentonAveB$`Status 2017`)),]
DentonAveB <- DentonAveB[!is.na(DentonAveB$`Tag ID`),]

attr(DentonAveB, "Length") <- "36 m."
attr(DentonAveB, "Width") <- "20 m."
attr(DentonAveB, "Area") <- "720 sq m."

usethis::use_data(DentonAveB, overwrite = TRUE)
