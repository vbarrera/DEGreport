% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllClasses.R, R/AllGenerics.R, R/AllMethods.R
\name{DEGSet}
\alias{DEGSet}
\alias{DEGSet-class}
\alias{as.DEGSet}
\alias{as.DEGSet,TopTags-method}
\alias{as.DEGSet,data.frame-method}
\alias{as.DEGSet,DESeqResults-method}
\title{DEGSet}
\usage{
DEGSet(resList, default)

DEGSet(resList, default)

as.DEGSet(object, ...)

\S4method{as.DEGSet}{TopTags}(object, default = "raw", extras = NULL)

\S4method{as.DEGSet}{data.frame}(object, contrast, default = "raw", extras = NULL)

\S4method{as.DEGSet}{DESeqResults}(object, default = "shrunken", extras = NULL)
}
\arguments{
\item{resList}{List with results as elements containing log2FoldChange,
pvalues and padj as column. Rownames should be feature names. Elements
should have names.}

\item{default}{The name of the element to use by default.}

\item{object}{Different objects to be transformed to DEGSet when using \code{as.DEGSet}.}

\item{...}{Optional parameters of the generic.}

\item{extras}{List of extra tables related to the same comparison when using \code{as.DEGSet}.}

\item{contrast}{To name the comparison when using \code{as.DEGSet}.}
}
\description{
S4 class to store data from differentially expression analysis.
It should be compatible with different package and stores the information
in a way the methods will work with all of them.
}
\details{
For now supporting only \code{\link[DESeq2:results]{DESeq2::results()}} output.
Use constructor \code{\link[=degComps]{degComps()}} to create the object.

The list will contain one element for each comparison done.
Each element has the following structure:
\itemize{
\item DEG table
\item Optional table with shrunk Fold Change when it has been done.
}

To access the raw table use \code{deg(dgs, "raw")}, to access the
shrunken table use \code{deg(dgs, "shrunken")} or just \code{deg(dgs)}.
}
\examples{
library(DESeq2)
library(edgeR)
library(limma)
dds <- makeExampleDESeqDataSet(betaSD = 1)
colData(dds)[["treatment"]] <- sample(colData(dds)[["condition"]], 12)
design(dds) <-  ~ condition + treatment
dds <- DESeq(dds)
res <- degComps(dds, combs = c("condition"))
deg(res)
deg(res, tidy = "tibble")
# From edgeR
dge <- DGEList(counts=counts(dds), group=colData(dds)[["treatment"]])
dge <- estimateCommonDisp(dge)
res <- as.DEGSet(topTags(exactTest(dge)))
# From limma
v <- voom(counts(dds), model.matrix(~treatment, colData(dds)), plot=FALSE)
fit <- lmFit(v)
fit <- eBayes(fit, robust=TRUE)
res <- as.DEGSet(topTable(fit, n = "Inf"), "A_vs_B")
}
\author{
Lorena Pantano
}
