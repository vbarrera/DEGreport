% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clustering.R
\name{degPCA}
\alias{degPCA}
\title{smart PCA from count matrix data}
\usage{
degPCA(
  counts,
  metadata = NULL,
  condition = NULL,
  pc1 = "PC1",
  pc2 = "PC2",
  name = NULL,
  shape = NULL,
  data = FALSE
)
}
\arguments{
\item{counts}{matrix with count data}

\item{metadata}{dara.frame with sample information}

\item{condition}{character column in metadata to use to color samples}

\item{pc1}{character PC to plot on x-axis}

\item{pc2}{character PC to plot on y-axis}

\item{name}{character if given, column in metadata to print label}

\item{shape}{character if given, column in metadata to shape points}

\item{data}{Whether return PCA data or just plot the PCA.}
}
\value{
if \verb{results <-} used, the function return the output
of \code{\link[=prcomp]{prcomp()}}.
}
\description{
nice plot using ggplot2 from prcomp function
}
\examples{
data(humanGender)
library(DESeq2)
idx <- c(1:10, 75:85)
dse <- DESeqDataSetFromMatrix(assays(humanGender)[[1]][1:1000, idx],
colData(humanGender)[idx,], design=~group)
degPCA(log2(counts(dse)+0.5), colData(dse),
  condition="group", name="group", shape="group")
}
\author{
Lorena Pantano, Rory Kirchner, Michael Steinbaugh
}
