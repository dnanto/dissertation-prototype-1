#!/usr/bin/env RScript --vanilla

library(neogeonames)
library(readr, warn.conflicts = F, quietly = T, verbose = F)
library(dplyr, warn.conflicts = F, quietly = T, verbose = F)


args <- commandArgs(trailingOnly = T)
f <- if (args[1] == "-") file("stdin") else args[1] # file
d <- args[2] # delimiter
c <- args[3] # column
p <- args[4] # pattern
n <- if(length(args) <= 4) parallel::detectCores() else args[5] # cores


df <- read_delim(f, d, col_types = cols(.default = "c"))
country <- unique(df[[c]])
geo <- parallel::mclapply(country, geonamify_delim, delim = "[:,]", mc.cores = n)
df.ac <- data.frame(id = 1:length(geo), country = country, do.call(rbind, lapply(geo, `[[`, "ac")))
df.id <- data.frame(id = 1:length(geo), country = country, do.call(rbind, lapply(geo, `[[`, "id")))

# remove rows with missing country_code
df.coor <- df.id[!is.na(df.id$ac0), ]
# set admin codes with no parent code to NA, since they lack support
df.coor <- apply(cbind(df.coor, NA), 1, function(row)
  if(!is.na(j <- which(is.na(row))[1])) row[j-1]
)

# merge coordinate data
df.coor <- merge(
  data.frame(id = names(df.coor), geonameid = df.coor),
  neogeonames::geoname[c("geonameid", "latitude", "longitude")],
  by = "geonameid",
  all.x = T
)

# merge with admin codes and original data
df.coor <- merge(df.ac, df.coor, by = "id", all.x = T)
left_join(df, df.coor[2:ncol(df.coor)], by = c, all.x = T) %>%
  mutate_all(as.character) %>%
  mutate_all(coalesce, "?") %>%
  format_delim(d) %>%
  cat()
