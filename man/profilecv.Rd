\name{profilecv}
\alias{profilecv}
\title{Cross-Validation for Profile Analysis}
\description{
Implements the cross-validation described in Davison & Davenport (2002)
}
\usage{
profilecv(x, y)
}
\arguments{
  \item{x}{
 	Corresponds to the predictor Variable 
}
  \item{y}{
  	Corresponds to the Dependent Variable
}
}
\details{
The profile.cv() function requires two arguments: X and Y. The argument X corresponds to the predictor variables. This matrix of covariates may be in their own object or in the same object as the dependent variable. The Y argument corresponds to the dependent variable. This vector may be in a separate object or in the same object as X. The function returns the cross-validation technique described in Davison & Davenport (2002). The data must be specified as matrices and there can be no missing data. 
}
\value{
  \item{R2.full}{Test of the null hypothesis that R2 = 0}
  \item{R2.pat}{Test that the R2_pattern = 0}
  \item{R2.level}{Test that the R2_level = 0}
  \item{R2.full.lvl}{Test that the R2_full = R2_level = 0}
  \item{R2.full.pat}{Test that the R2_full = R2_pattern = 0}
}
\references{
Davison, M., & Davenport, E. (2002). Identifying criterion-related patterns of predictor scores using multiple regression. Psychological Methods, 7(4), 468-484.
}
\author{
Christopher David Desjardins \email{cddesjardins@gmail.com}
}
\seealso{
\code{\link{profilecv}}
}
\examples{
# see vignette("profanalnotes") for an example
}
\keyword{methods}
