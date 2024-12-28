## code to prepare `IramooB` dataset goes here

## code to prepare `IramooA` dataset goes here

IramooB <- read_xlsx("./inst/extdata/IramooB.xlsx")[,2:9]
colnames(IramooB)[c(1,7,8)] <- c("Tag ID","x-axis","y-axis")
IramooB <- IramooB[(IramooB$`Status 2017`=="Existing"|
                      IramooB$`Status 2017`=="Germinant" )|
                     (is.na(IramooB$`Status 2017`)),]
IramooB <- IramooB[!(IramooB$`Status 2020`=="Translocated"),]
IramooB <- IramooB[!is.na(IramooB$`Tag ID`),]

attr(IramooB, "Length") <- "20 m."
attr(IramooB, "Width") <- "14 m."
attr(IramooB, "Area") <- "280 sq m."


usethis::use_data(IramooB, overwrite = TRUE)
