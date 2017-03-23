

library(rstan)
library(coda)

d <- read.csv(file="data7a.csv")
head(d)

hcode="
data {
	int<lower=0> N; // sample size
int<lower=0> y[N]; // the number of survived seeds for each set of 8 seeds (dependent variable)
}
parameters {
real beta; // a coefficient of logistic regression model common across all individual seeds
real r[N]; // individual bias (random effects), perhaps given from the number of leaves of each plant
real<lower=0> s; // individual deviation
}
transformed parameters {
real q[N];
for (i in 1:N)
q[i] <- inv_logit(beta+r[i]); // inverse logit of survival probability
}
model {
for (i in 1:N)
y[i] ~ binomial(8,q[i]); // logistic regression using binomial sampling
beta~normal(0,1.0e+2); // uninformative prior of coefficient
for (i in 1:N)
r[i]~normal(0,s); // hierarchical prior of individual bias (random effects)
s~uniform(0,1.0e+4); // uninformative prior for r[i]
}
"

dat<-list(N=nrow(d),y=d$y)
d.fit<-stan(model_code = hcode,data=dat,iter=1000,chains=4)

d.fit

plot(d.fit)

d.fit.coda<-mcmc.list(lapply(1:ncol(d.fit),function(x) mcmc(as.array(d.fit)[,x,])))
 plot(d.fit.coda[,c(1:3,102)])
 
