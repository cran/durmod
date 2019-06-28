library(durmod)
data.table::setDTthreads(1)
set.seed(42)
dataset <- datagen(4000,1200)
print(dataset)
risksets <- list(c('job','program'), c('job'))
options(digits=3)
# just two iterations to save time

opt <- mphcrm(d ~ x1+x2+C(job,alpha)+D(duration)+S(alpha+1)+ID(id), data=dataset, risksets=risksets,
              control=mphcrm.control(threads=1,iters=2,callback=NULL))
best <- opt[[1]]
print(best)
summary(best)
mphdist(best)
mphcovs(best)

# Then make a state factor
state <- dataset[,factor(alpha+1,levels=1:2)]
levels(state) <- c('unemp','onprogram')
dataset$state <- state
names(risksets) <- levels(state)
dataset[, f := factor(sample(1:6,.N,replace=TRUE))]
dataset[, g := factor(sample(1:4,.N,replace=TRUE))]
opt <- mphcrm(d ~ x1+x2+C(job,alpha+f)+D(duration)+C(program,f*g) + S(state)+ID(id), data=dataset, 
              risksets=risksets, control=mphcrm.control(threads=1,iters=1,callback=NULL))

summary(opt[[1]])

# single risk
dataset <- dataset[state=='onprogram']
opt <- mphcrm(d ~ x1+x2+D(duration)+ID(id), data=dataset, 
              control=mphcrm.control(threads=1,iters=1,callback=NULL))
summary(opt[[1]]$par)