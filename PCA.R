#!/usr/bin/env Rscript 

# A script to produce the individual PCA plots
args <- commandArgs(trailingOnly=TRUE)

file <- args[1]
print(file)
fname <- args[2]
print(fname)
plotname <- args[3]
print(plotname)

print("loading matrix....")
library(Matrix)
print("loading irlba...")
library(irlba)
print("loading ggfortify...")
library(ggfortify)

Sys.setenv(file=file)
Sys.getenv("file")
system("echo $file")

p <- pipe("sed /^#/d $file | cut -f '10-' | ./a.out | cut -f '1-2'")

print(p)

x <- read.table(p, colClasses=c("integer","integer"), fill=TRUE, row.names=NULL)

head(x)

chr1 <- sparseMatrix(i=x[,2], j=x[,1], x=1.0)
print(dim(chr1))

pc = prcomp_irlba(chr1, n=2)
summary(pc)

filename <- paste0(fname,".tiff")
filename

tiff(filename=paste0(fname,".tiff"), units="in", width=8, height=8, res=300)
autoplot(pc, main=plotname, label=TRUE) +
theme(plot.title = element_text(hjust = 0.5)) +
geom_point(colour="blue")
dev.off()

