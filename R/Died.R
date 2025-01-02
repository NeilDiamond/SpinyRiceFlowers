#' Location of plants that have died in a particular year
#'
#' @param site site
#' @param year Year
#'
#' @return A data-frame of plants that have died with Tag ID, x-axis, and y-axis
#' @export
#'
#' @examples Died(BonThomasA, 2021)
Died <- function(site, year){
  result <- site[(site[,paste("Status", year-1)]=="Alive" |
                    site[,paste("Status", year-1)]=="Existing")  &
                    site[,paste("Status", year)]=="Dead",
                  c("Tag ID", "x-axis", "y-axis")]

  result[complete.cases(result),]
}
