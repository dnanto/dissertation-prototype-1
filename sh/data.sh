#!/usr/bin/env bash

## copy data

mkdir -p data
cp -r ~/Documents/OneDrive\ -\ George\ Mason\ University/dissertation/data .

## genbank metadata

ffidx.py data/genbank/10508.db -dump -fo gb | \
  ffqual.py - collection_date country | \
  ndate.R - $'\t' date %Y-%m-%d collection_date dbY Ymd bY Y | \
  ngeon.R - $'\t' country "[:,]" > \
  data/genbank/10508.tsv

## blast database

mkdir -p data/blast

ffidx.py data/genbank/10508.db -dump -fo gb | \
  ffqual.py - db_xref | \
  awk -F '\t' 'NR > 1 { match($2, /taxon:([0-9]+)/, arr); print $1, arr[1] ? arr[1] : 0; }' > \
  data/blast/10508.ssv

rm -f data/blast/10508.log
ffidx.py data/genbank/10508.db -dump | \
  makeblastdb \
    -in - -dbtype nucl \
    -title 10508 -out data/blast/10508 \
    -parse_seqids -hash_index -blastdb_version 5 \
    -taxid_map data/blast/10508.ssv -logfile data/blast/10508.log
