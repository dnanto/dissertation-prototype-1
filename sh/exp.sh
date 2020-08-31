#!/usr/bin/env bash

# B-55
## genome
snakemake -j 16 --configfile workflow/conf/config.yml --config acc=FJ643676.1 pid="" --
## penton
snakemake -j 16 --configfile workflow/conf/config.yml --config acc=FJ643676.1 pid=ACU57010.1 --
## hexon
snakemake -j 16 --configfile workflow/conf/config.yml --config acc=FJ643676.1 pid=ACU57015.1 --
## fiber
snakemake -j 16 --configfile workflow/conf/config.yml --config acc=FJ643676.1 pid=ACU57030.1 --
