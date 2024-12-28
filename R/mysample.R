mysample <- function(mm, threshold=10^{-5}){
  x <- as.numeric(mm)
  xsmall <- (1:length(x))[x<threshold]
  xlarge <- setdiff(1:length(x),xsmall)
  xlargesample <- sample(xlarge, length(xlarge), prob=x[xlarge])
  xsmallsample <- sample(xsmall, length(xsmall))
  c(xlargesample, xsmallsample)
}
