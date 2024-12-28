#' Title
#'
#' @param quadratprobs  quadrat probabilies
#' @param nsim Number of simulations
#'
#' @return Vector of inclusion probabilities
#' @export
#'
#' @examples
#'
#' inclusionprobs(c(0.5,0.15,0.3, 0.05),nsim=100000)

inclusionprobs  <- function(quadratprobs, nsim=10000){
  quadratid <- as.vector(outer(row.names(quadratprobs),
                               colnames(quadratprobs),"paste"))
  names(quadratprobs) <- quadratid
  samp <- replicate(nsim,
                    wrswoR::sample_int_crank(length(quadratprobs),
                                             length(quadratprobs), quadratprobs))


  incprobsmat <-
    purrr::map_df(1:nrow(samp),
                  function(i) table(samp[1:i,],
                                    exclude=NULL)/ncol(samp))

  incprobsmat <- purrr::map_df(incprobsmat, function(x) {x[is.na(x)] <- 0; x})
  incprobsmat <- incprobsmat[,as.character(1:nrow(incprobsmat))]
  incprobsmat <- cbind(1:nrow(incprobsmat),incprobsmat)

  colnames(incprobsmat) <- c("ss",paste0("q",1:nrow(incprobsmat)))
  return(incprobsmat)
}
