\name{montecarlo.gwr}
\alias{montecarlo.gwr}
\title{Monte Carlo (randomisation) test for significance of GWR parameter variability}
\description{
This function uses Monte Carlo approach to do significance testing for the variability of individual parameters(regression coefficients)}
\usage{
montecarlo.gwr(formula, data = list(),nsims=99, kernel="gaussian",adaptive=F, bw,
                         p=2, theta=0, longlat=F,dMat)
}
\arguments{
  \item{formula}{Regression model formula of a \link{formula} object}
  \item{data}{a Spatial*DataFrame, i.e. SpatialPointsDataFrame or SpatialPolygonsDataFrame as defined in package \pkg{sp}}
  \item{nsims}{the number of randomisations}
  \item{kernel}{function chosen as follows:
  
                gaussian: wgt = exp(-.5*(vdist/bw)^2);
                
                exponential: wgt = exp(-vdist/bw);
                
                bisquare: wgt = (1-(vdist/bw)^2)^2 if vdist < bw, wgt=0 otherwise;
                
                tricube: wgt = (1-(vdist/bw)^3)^3 if vdist < bw, wgt=0 otherwise; 
                
                boxcar: wgt=1 if dist < bw, wgt=0 otherwise}
  \item{adaptive}{if TRUE calculate an adaptive kernel where the bandwidth (bw) corresponds to the number of nearest neighbours (i.e. adaptive distance); default is FALSE, where a fixed kernel is found (bandwidth is a fixed distance)}
  \item{bw}{bandwidth used in the weighting function, possibly calculated by \code{\link{bw.gwr}}}
  \item{p}{the power of the Minkowski distance, default is 2, i.e. the Euclidean distance}
  \item{theta}{an angle in radians to rotate the coordinate system, default is 0}
  \item{longlat}{if TRUE, great circle distances will be calculated}
  \item{dMat}{a pre-specified distance matrix, it can be calculated by the function \code{\link{gw.dist}}}
  }
\value{
  \item{pmat}{A vector containing p-values for all the GWR parameters}
}
\references{
Brunsdon C, Fotheringham AS, Charlton ME (1998) Geographically weighted regression - modelling spatial non-stationarity. 
Journal of the Royal Statistical Society, Series D-The Statistician 47(3):431-443


Charlton, M, Fotheringham, S, and Brunsdon, C (2007), GWR3.0, \url{http://www.nuim.ie/ncg/GWR/index.htm}.
}
\author{Binbin Lu \email{lubinbin220@gmail.com}}
\examples{
\dontrun{
data(LondonHP)
DM<-gw.dist(dp.locat=coordinates(londonhp))
bw<-bw.gwr(PURCHASE~FLOORSZ,data=londonhp,dMat=DM)
#See any difference in the next two commands and why?
res.mont1<-montecarlo.gwr(PURCHASE~PROF+FLOORSZ, data = londonhp,dMat=DM,
nsim=99,adaptive=FALSE, bw=3000)
res.mont2<-montecarlo.gwr(PURCHASE~PROF+FLOORSZ, data = londonhp,dMat=DM,
nsim=99,adaptive=FALSE, bw=300000000000)
}
}
\keyword{MonteCarlo , test}