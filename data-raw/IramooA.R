## code to prepare `IramooA` dataset goes here

IramooA <- read_xlsx("./inst/extdata/IramooA.xlsx")[,c(2:7,10:11)]
colnames(IramooA)[c(1,7,8)] <- c("Tag ID","x-axis","y-axis")
IramooA <- IramooA[(IramooA$`Status 2017`=="Existing"|
                      IramooA$`Status 2017`=="Germinant" )|
                           (is.na(IramooA$`Status 2017`)),]
IramooA <- IramooA[!is.na(IramooA$`Tag ID`),]

attr(IramooA, "Length") <- "4 m."
attr(IramooA, "Width") <- "13 m."
attr(IramooA, "Area") <- "52 sq m."

usethis::use_data(IramooA, overwrite = TRUE)
