#!/usr/bin/env RScript --vanilla

library(readr, warn.conflicts = F, quietly = T, verbose = F)
library(dplyr, warn.conflicts = F, quietly = T, verbose = F)


hit <- snakemake@input[["hit"]]
tsv <- snakemake@input[["tsv"]]
thr <- as.numeric(snakemake@params[["thr"]])

df.meta <- read_tsv(tsv, col_types = cols(date = "D", .default = "c"), na = "?")

# process hits
col_names <- c(
  "qaccver", "saccver", "pident", "length", "mismatch", "gapopen",
  "qstart", "qend", "sstart", "send", "evalue", "bitscore",
  "qlen", "sstrand", "staxid", "stitle"
)
col_types <- cols(
  length = "i", mismatch = "i", gapopen = "i", sstart = "i", send = "i", qlen = "i",
  .default = "c"
)
read_tsv(file.path(hit), col_names = col_names, col_types = col_types, comment = "#") %>%
  # filter date
  left_join(df.meta, c(saccver = "accver")) %>%
  filter(!is.na(date)) %>%
  # calculate qpidcov
  group_by(saccver) %>%
  summarise(
    qpidcov = (sum(length) - sum(gapopen) - sum(mismatch)) / first(qlen) * 100,
    start = min(sstart, send),
    end = max(sstart, send),
    strand = first(sstrand),
    staxid = first(staxid),
    stitle = first(stitle),
    date = first(date),
    .groups = "drop"
  ) %>%
  filter(qpidcov >= thr) %>%
  arrange(date) %>%
  # output metadata
  write_tsv(snakemake@output[["tsv"]]) %>%
  # output entry batch
  with({
    write_lines(sprintf("%s %d-%d %s", saccver, start, end, strand), snakemake@output[["ssv"]])
    write_lines(sprintf("/^>/ s/(%s)/\\1_%s/", saccver, date), snakemake@output[["sed"]])
  })
