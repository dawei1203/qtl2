% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_scan1perm.R
\name{summary_scan1perm}
\alias{summary_scan1perm}
\alias{summary.scan1perm}
\title{Summarize scan1perm results}
\usage{
summary_scan1perm(object, alpha = 0.05)

\method{summary}{scan1perm}(object, alpha = 0.05, ...)
}
\arguments{
\item{object}{Output of \code{\link[=scan1perm]{scan1perm()}}}

\item{alpha}{Vector of significance levels}

\item{...}{Ignored}
}
\value{
An object of class \code{summary.scan1perm}. If
\code{\link[=scan1perm]{scan1perm()}} was run with \code{perm_Xsp=FALSE}, this is
a single matrix of significance thresholds, with rows being
signicance levels and columns being the columns in the input. If
\code{\link[=scan1perm]{scan1perm()}} was run with \code{perm_Xsp=TRUE}, this is
a list of two matrices, with the significance thresholds for the
autosomes and X chromosome, respectively.

The result has an attribute \code{"n_perm"} that has the numbers of
permutation replicates (either a matrix or a list of two matrices).
}
\description{
Summarize permutation test results from \code{\link[=scan1perm]{scan1perm()}}, as significance thresholds.
}
\details{
In the case of X-chromosome-specific permutations (when
\code{\link[=scan1perm]{scan1perm()}} was run with \code{perm_Xsp=TRUE}, we
follow the approach of Broman et al. (2006) to get separate
thresholds for the autosomes and X chromosome, using

Let \eqn{L_A} and \eqn{L_X} be total the genetic lengths of the
autosomes and X chromosome, respectively, and let \eqn{L_T = L_A +
L_X} Then in place of \eqn{\alpha}{alpha}, we use \deqn{\alpha_A =
1 - (1-\alpha)^{L_A/L_T}}{alpha_A = 1 - (1 - alpha)^(L_A/L_T)} as
the significance level for the autosomes and \deqn{\alpha_X = 1 -
(1-\alpha)^{L_X/L_T}}{alpha_x = 1 - (1 - alpha)^(LX/LT)} as the
significance level for the X chromosome.
}
\examples{
# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
\dontshow{iron <- iron[,c(10,18,"X")]}

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# permutations with genome scan
\dontrun{
operm <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar,
                   n_perm=1000, perm_Xsp=TRUE,
                   chr_lengths=chr_lengths(iron$gmap))}
\dontshow{operm <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar, n_perm=3)}

summary(operm, alpha=c(0.20, 0.05))

}
\references{
Broman KW, Sen Ś, Owens SE, Manichaikul A, Southard-Smith EM,
Churchill GA (2006) The X chromosome in quantitative trait locus
mapping. Genetics 174:2151-2158
}
