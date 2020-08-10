#!/usr/bin/env RScript --vanilla

library(lubricity)
library(readr, warn.conflicts = F, quietly = T, verbose = F)
library(dplyr, warn.conflicts = F, quietly = T, verbose = F)

args <- commandArgs(trailingOnly = T)
f <- if (args[1] == "-") file("stdin") else args[1] # file
d <- args[2] # delimiter
c <- args[3] # column
p <- args[4] # pattern

read_delim(f, d, col_types = cols(.default = "c")) %>%
  bind_cols(
    .,
    apply(.[c], 1, process_delim, pattern = p) %>%
      bind_rows() %>%
      mutate_all(coalesce, "?")
  ) %>%
  format_delim(d) %>%
  cat()
