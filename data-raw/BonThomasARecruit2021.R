## code to prepare `BonThomasARecruit2021` dataset goes here

BonThomasARecruit2021 <-
  BonThomasA[BonThomasA$`Status 2020`=="Germinant" &
             BonThomasA$`Status 2021`=="Alive",
             c("Tag ID", "x-axis", "y-axis")]


usethis::use_data(BonThomasARecruit2021, overwrite = TRUE)
