#' Location of plants that are recruits in a particular year
#'
#' @param site Site
#' @param year Year
#'
#' @return A data-frame of plants that are recruits with Tag ID, x-axis, and y-axis
#' @export
#'
#' @examples Recruits(BonThomasA, 2021)
Recruits <- function(site, year){
  result <- site[site[,paste("Status", year-1)]=="Germinant" &
               site[,paste("Status", year)]=="Alive",
             c("Tag ID", "x-axis", "y-axis")]
  result[complete.cases(result),]
}

