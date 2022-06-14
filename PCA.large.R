#!/usr/bin/env Rscript


library(Matrix)
library(parallel)
t0 = proc.time()
chunksize = 100000000
meta = Reduce(rbind, mcMap(function(f)
{
  name = gsub("\\.gz", "", f); message(name)
  chunk = 1
  p = pipe(sprintf("zcat %s  | sed /^#/d | cut  -f '10-' | ./a.out | cut -f '1-2'", f), open="r")
  meta = data.frame()
  while(chunk > 0)
  {
    x = tryCatch(read.table(p, colClasses=c("integer", "integer"), fill=TRUE, row.names=NULL, nrows=chunksize),
                 error=function(e) data.frame())
    if(nrow(x) < 1) chunk = 0
    else
    {
      x = sparseMatrix(i=x[, 1] - x[1, 1] + 1, j=x[, 2], x=1.0)
      attr(x, "rowmeans") = rowMeans(x)
      cfn = sprintf("%s-%d.rdata", name, chunk)
      cf = file(cfn, open="wb")
      serialize(x, connection=cf, xdr=FALSE)
      close(cf)
      meta = rbind(meta, data.frame(file=cfn, nrow=nrow(x), ncol=ncol(x), stringsAsFactors=FALSE))
      chunk = chunk + 1
    }
    rm(x)
    gc()
  }
  close(p)
  meta
}, dir(pattern="reformatted_Shetland_fd.vcf.gz"), mc.cores=2))
print(proc.time() - t0)
meta$end = cumsum(meta$nrow)
meta$start = c(1, meta$end[-length(meta$end)] + 1)
saveRDS(meta, file="meta_SI.rdata")
