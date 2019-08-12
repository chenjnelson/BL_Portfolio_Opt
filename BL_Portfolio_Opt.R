#NLP Section
library(quadprog)

#input Covariance Matrix here
covMat = 
Dmat = 2 * covMat
dvec = rep(0,nrow(covMat))

#input expected returns of each asset class here
means = 
Rvalues = c(seq(min(means),max(means),((max(means)-min(means))/100)))
Amat = t(rbind(rep(1,nrow(covMat)), rep(-1, nrow(covMat)), means, diag(nrow(covMat))))

StdDevs=rep(0,length(Rvalues))
Var = rep(0,length(Rvalues))
expected_return = rep(0,length(Rvalues))
Weights = matrix(0,101,nrow(covMat))

#Efficient Frontier
for (i in 1:length(Rvalues)){
  bvec = c(1,-1,Rvalues[i],rep(0,nrow(covMat)))
  S=solve.QP(Dmat,dvec,Amat,bvec)
  StdDevs[i]=sqrt(S$value)
  Var[i] = S$value
  expected_return[i] = S$solution %*% means
  Weights[i,] = S$solution
}

#Black Litterman model
#Input P and Q, which is your expectation of out/underperformance of the different assets under consideration
P=
q=

#Input your confidence
Omega = 
  
#input the desired tau
tau=
  
m2=solve(solve(tau*covMat)+t(P) %*% solve(Omega) %*% P) %*% (solve(tau*covMat) %*% means+ t(P) %*% solve(Omega) %*% q) 

expected_return_BL = rep(0,length(Rvalues))
Weights_BL = matrix(0,101,nrow(covMat))
Amat2 = t(rbind(rep(1,nrow(covMat)), rep(-1, nrow(covMat)), t(m2), diag(nrow(covMat))))
StdDevsBL=rep(0,length(Rvalues))

for (i in 1:length(Rvalues)){
  bvec = c(1,-1,Rvalues[i],rep(0,nrow(covMat)))
  Sol=solve.QP(Dmat,dvec,Amat2,bvec)
  expected_return_BL[i] = Sol$solution %*% m2
  Weights_BL[i,] = Sol$solution
  StdDevsBL[i] = sqrt(Sol$value)
  
}

#visualizations
require(ggplot2)

df <- data.frame(returns = Rvalues, StdDev = StdDevs)
ggplot(df, aes(x = StdDev, y = returns)) +  geom_line(colour = "blue", size = 2)

df2 <- data.frame(returns = Rvalues, Weight = as.vector(Weights), asset = rep(paste0('asset', 1:nrow(covMat)), each = 101))

ggplot(df2, aes(x = returns, y = Weight)) + geom_line(aes(colour = asset))

plot(StdDevs,Rvalues,type = 'l', col = 'red')
lines(StdDevsBL,Rvalues, type = 'l',col = 'blue')
matplot(Rvalues,Weights,type = 'l')

#Graph of fractions in each asset class for original
cumweights= apply(Weights,1,cumsum)
cumweights = t(cumweights)
matplot(Rvalues, cumweights, type= "l")

#Graph of fractions in each asset class for BL
cumweightsBL= apply(Weights_BL,1,cumsum)
cumweightsBL = t(cumweightsBL)
matplot(Rvalues, cumweightsBL, type= "l")
