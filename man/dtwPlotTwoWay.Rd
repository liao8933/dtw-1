\name{dtwPlotTwoWay}
\alias{dtwPlotTwoWay}



%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plotting of dynamic time warp results: pointwise comparison}
\description{
  Display the query and reference time series and their alignment,
  arranged for visual inspection.
}

\usage{
dtwPlotTwoWay(d,xts=NULL,yts=NULL, offset=0,
			ts.type="l",pch=21, 
                        match.indices=NULL,
			match.col="gray70", match.lty=3,
			xlab="Index", ylab="Query value", 
			... )
}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{d}{ an alignment result, object of class \code{dtw}}
  \item{xts}{ query vector }
  \item{yts}{  reference vector }
  \item{xlab,ylab}{axis labels}
  \item{offset}{displacement between the timeseries, summed to reference}
  \item{match.col, match.lty}{color and line type of the match guide lines}
  \item{match.indices}{indices for which to draw a visual
    guide}
  \item{ts.type,pch}{graphical parameters for timeseries plotting, passed to \code{matplot}}
  \item{...}{additional arguments, passed to \code{matplot}}
}

\details{

  The two vectors are displayed via the \code{\link{matplot}} functions;
  their appearance can be customized via the \code{type} and \code{pch}
  arguments (constants or vectors of two elements).  If \code{offset} is
  set, the reference is shifted vertically by the given amount; this will
  be reflected by the \emph{right-hand} axis.

  Argument \code{match.indices} is used to draw a visual guide to
  matches; if a vector is given, guides are drawn for the corresponding
  indices in the warping curve (match lines). If integer, it is used as
  the number of guides to be plotted. The corresponding style is
  customized via the \code{match.col} and \code{match.lty} arguments.

  If \code{xts} and \code{yts} are not supplied, they will be recovered
  from \code{d}, as long as it was created with the two-argument call of
  \code{\link{dtw}}  with \code{keep.internals=T}.  Only
  single-variate time series can be plotted this way.
  
}


\author{Toni Giorgino }

\note{
  When \code{offset} is set values on the left axis only apply to
  the query.
}

\section{Warning}{ The function is incompatible with mechanisms for
     arranging plots on a device: \code{par(mfrow)}, \code{layout} and
     \code{split.screen}.}


\seealso{ \code{\link{dtwPlot}} for other dtw plotting functions,
\code{\link{matplot}} for graphical parameters. }

\examples{

## A noisy sine wave as query
## A cosine is for reference; sin and cos are offset by 25 samples

idx<-seq(0,6.28,len=100);
query<-sin(idx)+runif(100)/10;
reference<-cos(idx)
dtw(query,reference,step=asymmetricP1,keep=TRUE)->alignment;


## Equivalent to plot(alignment,type="two");
dtwPlotTwoWay(alignment);


## Highlight matches of chosen QUERY indices. We will do some index
## arithmetics to recover the corresponding indices along the warping
## curve

hq <- (0:8)/8              
hq <- round(hq*100)      #  indices in query for  pi/4 .. 7/4 pi

hw <- (alignment$index1 \%in\% hq)   # where are they on the w. curve?
hi <- (1:length(alignment$index1))[hw];   # get the indices of TRUE elems


## Beware of the reference's y axis, may be confusing
plot(alignment,offset=-2,type="two", lwd=3, match.col="grey50",
     match.indices=hi,main="Match lines shown every pi/4 on query");

legend("topright",c("Query","Reference (rt. axis)"), pch=21, col=1:6)



}

\concept{Dynamic Time Warp}


\keyword{ hplot }

