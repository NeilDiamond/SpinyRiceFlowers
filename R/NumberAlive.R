#' Number of Alive Plants at a Site in a particular year
#'
#' @param Site Site
#' @param year Year
#'
#' @return The number of alive plants
#' @export
#'
#' @examples NumberAlive(BonThomasA, 2020)
NumberAlive <- function(Site, year){
  status <- table(Site[,paste("Status", year)])
  status[names(status)%in%c("Alive","Existing")]
}
