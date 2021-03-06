#' A package for estimating a mixed proportional hazard competing risk model with the NPMLE.
#'
#' 
#' The main method of the package is \code{\link{mphcrm}}. It has an interface
#' somewhat similar to \code{\link{lm}}.  There is an example of use in \code{\link{datagen}}, with
#' a generated dataset similiar to the ones in \cite{Gaure et al. (2007)}. For those who have
#' used the program used in that paper, a mixture of R, Fortran, C, and python,
#' this is an entirely new self-contained package, written from scratch with 12 years of experience.
#' Currently not all functionality from that behemoth has been implemented, but most of it.
#'
#' A short description of the model follows.
#'
#' There are some individuals with some observed covariates \eqn{X_i}. The individuals are
#' observed for some time, so there is typically more than one observation of each individual.
#' At any point they experience one or more hazards. The hazards are assumed to be of the form
#' \eqn{h_i^j = exp(X_i \beta_j)}, where \eqn{\beta_j} are coefficients for hazard \eqn{j}.
#' The hazards themselves are not observed, but an event associated with them is, i.e. a transition
#' of some kind. The time of the transition, either exactly recorded, or within an interval, must also
#' be in the data set.  With enough observations it is then possible to estimate the coefficients \eqn{\beta_j}.
#'
#' However, it just so happens that contrary to ordinary linear models, any unobserved heterogeneity
#' may bias the estimates, not just increase uncertainty.  To account for unobserved heterogeneity, a
#' random intercept is introduced, so that the hazards are of the form \eqn{h_i^j(\mu_k) = exp(X_i \beta_j + \mu_k)}
#' for \eqn{k} between 1 and some \eqn{n}. The intercept may of course be written multiplicatively as
#' \eqn{exp(X_i \beta_j) exp(\mu_k)}, that is why they are called \emph{proportional} hazards.
#' 
#' The individual likelihood depends on the intercept, i.e. \eqn{L_i(\mu_k)}, but we integrate it out
#' so that the individual likelihood becomes \eqn{\sum p_k L_i(\mu_k)}. The resulting mixture
#' likelihood is maximized over all the \eqn{\beta}s, \eqn{n}, the \eqn{\mu_k}s, and the probabilities \eqn{p_k}.
#' 
#' Besides the function \code{\link{mphcrm}} which does the actual estimation, there are functions for
#' extracting the estimated mixture, they are \code{\link{mphdist}}, \code{\link{mphmoments}} and a few more.
#'
#' There's a summary function for the fitted model, and there is a data set available with \code{data(durdata)} which
#' is used for demonstration purposes. Also, an already fitted model is available there, as \code{\link{fit}}.
#' 
#' The package may use more than one cpu, the default is taken from \code{getOption("durmod.threads")}
#' which is initialized from the environment variable \env{DURMOD_THREADS}, \env{OMP_THREAD_LIMIT},
#' \env{OMP_NUM_THREADS} or \env{NUMBER_OF_PROCESSORS}, or parallel::detectCores() upon loading the package.
#'
#' For more demanding problems, a cluster of machines (from packages \pkg{parallel} or \pkg{snow}) can be
#' used, in combination with the use of threads.
#' 
#' There is a vignette (\code{vignette("whatmph")}) with more details about \pkg{durmod} and data layout.
#' @references
#' Gaure, S., K. Røed and T. Zhang (2007) \cite{Time and causality: A Monte-Carlo Assessment
#'   of the timing-of-events approach}, Journal of Econometrics 141(2), 1159-1195.
#' \url{https://doi.org/10.1016/j.jeconom.2007.01.015}
#' @name durmod-package
#' @aliases durmod
#' @docType package
#' @useDynLib durmod, .registration=TRUE
#' @importFrom Rcpp evalCpp
#' @import 'stats'
#' @import 'utils'
#' @importFrom nloptr nloptr
#' @importFrom numDeriv grad hessian jacobian
#' @importFrom parallel detectCores
#' @importFrom data.table data.table setattr
#' @importFrom mvtnorm rmvnorm
NULL

