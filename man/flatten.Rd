% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R
\name{flatten}
\alias{flatten}
\alias{unflatten}
\title{Convert a structured coefficient set to a vector}
\usage{
flatten(x, exclude = attr(x, "exclude"))

unflatten(
  flesh,
  skeleton = attr(flesh, "skeleton"),
  exclude = attr(flesh, "exclude")
)
}
\arguments{
\item{x}{parameter set as typically found in \code{opt[[1]]\$par},
where \code{opt} is returned from \code{mphcrm}.}

\item{exclude}{For internal use}

\item{flesh}{vector of class \code{"relistable"}, as returned from \code{\link{flatten}}.}

\item{skeleton}{For internal use}
}
\description{
\code{\link{mphcrm}} stores coefficients in a list,
  not in a vector. This is because they should be treated
  differently according to whether they are probabilities,
  proportional hazards, or coefficients for factor levels or
  ordinary covariates.  \code{flatten} extracts them as a named
  vector. \code{unflatten} puts them back in structured form.
}
\details{
\code{flatten}/\code{unflatten} is just a thinly disguised
  \code{\link[base]{unlist}}/\code{\link[utils]{relist}}, but uses
  slightly more readable names.
}
