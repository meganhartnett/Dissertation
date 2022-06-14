#!/usr/bin/env Rscript

library(irlba)
library(Matrix)
library(parallel)
library(ggplot2)

args <- commandArgs(trailingOnly=TRUE)

fname <- args[1]
print(fname)

meta = readRDS("meta_intersect.rdata")
meta$file = sprintf("%s/%s", getwd(), meta$file)

setClass("pmat", contains="list", S3methods=TRUE, slots=c(dims="numeric"))
setMethod("%*%", signature(x="pmat", y="numeric"), function(x ,y)
  {
    ans = rep(0.0, nrow(x))
    p = mcMap(function(i)
    { 
      f = file(x$file[i], open="rb")
      a = unserialize(f)
      close(f)
      r = attr(a, "rowmeans") #rowMeans(a)
      drop(a %*% y - r * drop(crossprod(rep(1, length(y)), y)))
    }, 1:length(x$file), mc.cores=4)
    i = 1
    for(j in 1:length(p))
    { 
      k = length(p[[j]])
      ans[i:(i + k - 1)] = p[[j]]
      i = i + k
    }
    gc()
    ans
  })
setMethod("%*%", signature(x="numeric", y="pmat"), function(x ,y)
  {
    ans = Reduce(`+`, mcMap(function(i)
    { 
      f = file(y$file[i], open="rb")
      a = unserialize(f)
      close(f)
      j = seq(from=y$start[i], to=y$end[i])
      drop(x[j] %*% a - drop(crossprod(x[j], attr(a, "rowmeans"))))
    }, 1:length(y$file), mc.cores=4))
    gc()
    ans
  })
A = new("pmat", as.list(meta), dims=c(tail(meta$end, 1), meta$ncol[1]))
dim.pmat = function(x) x@dims
nrow.pmat = function(x) x@dims[1]
ncol.pmat = function(x) x@dims[2]

#row.names.df1<-501
#A1 <- A[!(row.names(A) %in% row.names.df1),]
#print(pmat)

t1 = proc.time()
L  = irlba(A, nv=2, tol=1e-5, right_only=TRUE, work=4)
dt = proc.time() - t1
print(dt)
#save(dt, L, file="chunked_SI.out")

df <- data.frame(x = L$v[, 1], y = L$v[, 2])
#head(df)
#print(df$x)
#print(df$y)


f = dir(pattern="*\\.vcf\\.gz")[[1]]
cmd = sprintf("zcat %s |head -n 500 | grep '^#CHROM' |cut  -f 10-", f)
p = pipe(cmd)
ids = scan(p, what=character(), sep="\t")

ped = read.csv("20130606_g1k.ped", sep="\t", header=TRUE, stringsAsFactors=FALSE)
row.names(ped) = ped[["Individual.ID"]]
ped = ped[ids, ]
ped$Population = factor(ped$Population, levels=c("CHB", "JPT", "CHS", "CDX", "KHV", "CEU", "TSI", "FIN", "GBR", "IBS", "YRI", "LWK", "GWD", "MSL", "ESN", "ASW", "ACB", "MXL", "PUR", "CLM", "PEL", "GIH", "PJL", "BEB", "STU", "ITU"))
clrs = rainbow(length(levels(ped$Population)))[ped$Population]
labels= levels(ped$Population)[ped$Population]


ggplot(df, aes(x = x, y = y) +
geom_point(color= clrs, label=labels) +
geom_text(label=rownames(df)) +
ggtitle("PCA Plot of the Promoter Regions in the 1000 Genomes Individuals") +
xlab("PC1") + ylab("PC2") +
theme(plot.title = element_text(color="black", size=14, face="bold.italic", hjust=0.5), axis.title.x = element_text(color="black", size=14, face="bold"), axis.title.y = element_text(color="black", size=14, face="bold"))
ggsave(filename=paste0(fname,".tiff"), device= "tiff", width = 8, height = 8, units = "in")



