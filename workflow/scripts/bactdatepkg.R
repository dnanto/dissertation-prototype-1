#!/usr/bin/env RScript --vanilla

if (!require(BactDating)) devtools::install_github("xavierdidelot/BactDating")

writeLines(paste(packageVersion("BactDating"), sep="."), snakemake@output[["ver"]])
