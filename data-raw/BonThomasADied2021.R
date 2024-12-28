## code to prepare `BonThomasADied2021` dataset goes here

BonThomasADied2021 <- BonThomasA[BonThomasA$`Status 2020`=="Alive" &
                          BonThomasA$`Status 2021`=="Dead",
                          c("Tag ID", "x-axis position", "y-axis position")]

usethis::use_data(BonThomasADied2021, overwrite = TRUE)
