#' Quadrat counts of changes in a particular year
#'
#' @param site Sampling site
#' @param year Year
#' @param quadratsize Size of quadrats (m)
#' @param quadratstart Lower left starting position of quadrats
#'
#' @return A contingency table containing the change (recruits - died) in each quadrat
#' @export
#'
#' @examples
#' Change(BonThomasA, 2021, quadratsize=5)
#'
#' Change(BonThomasA, 2021, quadratsize=4, quadratstart=c(2,1))
#'
Change <- function(site, year, quadratsize=5,
                   quadratstart=c(0,0)){
  len <- as.numeric(gsub("\\D", "", attr(site,"Length")))
  wdth <- as.numeric(gsub("\\D", "", attr(site,"Width")))
  recruits <- Recruits(site, year)
  died <- Died(site, year)
  xbr <- seq(quadratstart[1], len, quadratsize)
  ybr <- seq(quadratstart[2], wdth, quadratsize)

  qxDied <- spatstat.geom::quadratcount(
    spatstat.geom::ppp(
      unlist(died[, 2]),
      unlist(died[, 3]),
      window = spatstat.geom::owin(
        xrange = c(min(xbr), max(xbr)),
        yrange = c(min(ybr), max(ybr)))),
    xbreaks = xbr,
    ybreaks = ybr
  )

  qxRecruits <- spatstat.geom::quadratcount(
    spatstat.geom::ppp(
      unlist(recruits[, 2]),
      unlist(recruits[, 3]),
      window = spatstat.geom::owin(
        xrange = c(min(xbr), max(xbr)),
        yrange = c(min(ybr), max(ybr)))),
    xbreaks = xbr,
    ybreaks = ybr
  )

   qxRecruits-qxDied
}




