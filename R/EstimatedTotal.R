EstimatedTotal <- function(ss, site, year, quadratsize=5,
                           quadratstart=c(0,0),
                           probs,
                           incprobsmat,
                           nreps = 10000){
incprobs <- incprobsmat[ss,]
AliveYearBefore <- NumberAlive(site, year-1)
qChange <- Change(site, year, quadratsize=quadratsize, quadratstart=quadratstart)
#results <- table(replicate(nreps,calctot(ss,
#                     probs=probs,
#                     incprobs=incprobs,
#                     qx=qChange)))
results <- replicate(nreps,calctot(ss,
                                         probs=probs,
                                         incprobs=incprobs,
                                         qx=qChange))
#names(results) <- as.numeric(names(results))+AliveYearBefore
#list(Hmisc::wtd.mean(as.numeric(names(results)), results),
#     sqrt(Hmisc::wtd.var(as.numeric(names(results)), results)))
cv <- round(100*sd(results, na.rm=T)/(mean(results, na.rm=T)+AliveYearBefore),2)
list(mean(results, na.rm=T)+AliveYearBefore,sd(results, na.rm=T),cv)
}

