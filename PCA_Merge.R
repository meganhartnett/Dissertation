#!/usr/bin/env Rscript

# A script to produce the individual PCA plots
args <- commandArgs(trailingOnly=TRUE)

file <- args[1]
print(file)
file2 <- args[2]
print(file2)
fname <- args[3]
print(fname)
plotname <- args[4]
print(plotname)

print("loading matrix....")
library(Matrix)
print("loading irlba...")
library(irlba)
print("loading ggfortify...")
library(ggfortify)
print("loading factrominer...")
library("FactoMineR")
print("loading factroextra...")
library("factoextra")

Sys.setenv(file=file)
Sys.getenv("file")
system("echo $file")


Sys.setenv(file2=file2)
Sys.getenv("file2")
system("echo $file2")

p <- pipe("sed /^#/d $file | cut -f '10-' | ./a.out | cut -f '1-2'")
t <- pipe("sed /^#/d $file2 | cut -f '10-' | ./a.out | cut -f '1-2'")

print(p)
print(t)

x1 <- read.table(p, colClasses=c("integer","integer"), fill=TRUE, row.names=NULL)
x2 <- read.table(t, colClasses=c("integer","integer"), fill=TRUE, row.names=NULL)

head(x1)
head(x2)

X = list(df1=x1,df2=x2)
labels = rep(names(X),sapply(X,nrow))
table(labels)

pc_s <- do.call(rbind,X)
head(pc_s)

length(pc_s[,2])
length(pc_s[,1])

chr1 <- sparseMatrix(i=pc_s[,2], j=pc_s[,1], x=1.0)
print(dim(chr1))

pc = prcomp_irlba(chr1, n=2)
summary(pc)

filename <- paste0(fname,".tiff")
filename

tiff(filename=paste0(fname,".tiff"), units="in", width=8, height=8, res=300)
fviz_pca_ind(pc, geom.ind = "point",  addEllipses = TRUE, legend.title = "Groups")
dev.off()

