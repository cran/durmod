## ----data----------------------------------------------------------------
library(durmod)
data(durdata)
head(durdata,15)

## ------------------------------------------------------------------------
risksets <- list(unemp=c('job','program'), onprogram='job')

## ------------------------------------------------------------------------
ctrl <- mphcrm.control(iters=6, threads=2)

## ------------------------------------------------------------------------
set.seed(42) # for reproducibility
opt <- mphcrm(d ~ x1 + x2 + 
                C(job, alpha) + ID(id) + D(duration) + S(state), 
              data=durdata, risksets=risksets, control=ctrl)

## ------------------------------------------------------------------------
print(opt)

## ------------------------------------------------------------------------
best <- opt[[1]]
summary(best)

## ------------------------------------------------------------------------
t(sapply(opt, function(o) summary(o)$coefs["job.alpha",]))

