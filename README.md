Black-Litterman Portfolio
------

A general portfolio optimization problem is to build an allocation of assets that minimizes the portfolio variance for an expected return, thus creating an [efficient frontier] (https://www.investopedia.com/terms/e/efficientfrontier.asp). 

The problem is outlined as such (no-shorting, which can also be changed in the formulation):


![](https://latex.codecogs.com/gif.latex?%7B%5Cmin%20%5C%3B%20%7D%20%26%20x%5ETCx%20%24%20%5C%5C%20%7B%5C%5C%5B.5%20cm%5D%20s.t.%7D%20%26%20m%5ETx%20%3D%20R%20%24%20%5C%5C%20%7B%5C%3B%20%5C%3B%20%5C%3B%20%5C%3B%20%5C%3B%20%5C%3B%20%5C%3B%20%5C%3B%7D%5Csum_%7Bi%7D%5E%7Bn%7D%20x_i%20%3D%201%20%24%20%5C%5C%20%26%20%5Cphantom%7B%3D%7D%5C%20%26%20%5Cphantom%7B%3D%7D%5C%20x_i%20%5Cge%200%20%26%20%5C%3B%20%5Cforall%20%5C%3B%20i)


Portfolio optimization attempts to minimize in-sample variance, and as such an expectation is that the correlation of assets is expected to hold (which in practice, is not necessarily true as many assets are quite sensitive to one another) for the duration which the portfolio construction process is intended. In addition, future beliefs that we as investors hold are not factored into the future. This is where the [Black-Litterman](http://www.globalriskguard.com/resources/assetman/bayes_0008.pdf) model can come into play. This model can adjust the expectation of period's returns through the equation:

![](https://latex.codecogs.com/gif.latex?m%20%3D%20%5B%28%5Ctau%20C%29%5E%7B-1%7D%20&plus;%20P%5ET%5COmega%5E%7B-1%7DP%5D%5E%7B-1%7D%5B%28%5Ctau%20C%29%5E%7B-1%7Dm%20&plus;%20P%5ET%20%5COmega%5E%7B-1%7Dq%5D)

where *tau* represents a small constant, *C* is the covariance matrix of excess returns, matrix *P* and *vector* q are the beliefs on the expected return such that *P* x *m* = q, *Omega* is the diagonal matrix representing confidence levels (the smaller, the stronger the view), and *m* marking the historical average returns. Note there are also discussions online on the best values to assign [*tau*](https://quant.stackexchange.com/questions/40820/struggling-with-tau-in-black-litterman) and [*Omega*](https://quant.stackexchange.com/questions/16280/black-litterman-how-to-choose-the-uncertainty-in-the-views-omega-for-smooth?rq=1).

This code will run both the vanilla portfolio optimization and the Black-Litterman model, given the inputs. The packages used are `quadprog` and `ggplot2` in R.

![](https://github.com/njinchen/BL_Portfolio_Opt/blob/master/Efficient_Frontiers.png) 

We can see the slight differences in the efficient frontiers based on our expectations of returns across the asset classes, in a sample run

![]
(https://github.com/njinchen/BL_Portfolio_Opt/blob/master/Asset_Weights.PNG)

![]
(https://github.com/njinchen/BL_Portfolio_Opt/blob/master/Asset_Weights_BL.PNG)

As well as the differing weight values to achieve the return given a level of risk 









