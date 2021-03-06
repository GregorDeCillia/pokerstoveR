% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ps_eval.R
\name{ps_eval}
\alias{ps_eval}
\title{Evaluate hand equities}
\usage{
ps_eval(..., board = NULL, verbose = FALSE)
}
\arguments{
\item{...}{Hands to be evaluated}

\item{board}{The board}

\item{verbose}{If \code{TRUE}, print the raw output of ps-eval to the
screen. Default is \code{FALSE}.}
}
\value{
A dataframe with the following columns
\itemize{
\item \strong{hand}: One of the hands specified in \code{...}
\item \strong{equity}: The equity of the hand in percent
\item \strong{wins}: number of wins in the iteration through the possibility space
\item \strong{ties}: number of wins that have to be added to \strong{wins} in order to respect
ties in the equity calculation. For the evaluation of two hands, this will
be half the number of ties.
}
}
\description{
This function calls \code{ps-eval} via \link{system} and uses string manipulation to convert
the output into a tidy dataframe.
}
\examples{
# ---------------- preflop --------------- #

ps_eval("AcAs", "2h7d")
ps_eval("2h2s", "TdJd", "As7s")

# ----------------- flop ----------------- #

ps_eval("AcAs", "2h7d", board = "2c2d2s")

# ----------------- turn ----------------- #

## 2 live overcars
ps_eval("2d2h", "AsKs", board = "4h5h6sTd")

## open ended straight flush draw
ps_eval("AdAh", "6s7s", board = "4s5s2hTh")

# ----------------- river ---------------- #

ps_eval("AdAh", "6s7s", board = "4s5s2hThAc")
}
