#!/usr/bin/env python3

import sys
from argparse import ArgumentDefaultsHelpFormatter, ArgumentParser, FileType
from collections import OrderedDict
from itertools import chain, groupby
from signal import SIG_DFL, SIGPIPE, signal

from Bio import SeqIO


def parse_outfmt7(stream):
    fields = []
    for line in map(str.strip, stream):
        if line.startswith("# Fields: "):
            fields = line[10:].split(", ")
        elif line and not line.startswith("#"):
            yield OrderedDict(zip(fields, line.split("\t")))


def aggregate(stream):
    for key, rows in groupby(parse_outfmt7(stream), lambda row: row["subject acc.ver"]):
        alen, gaps, mism, qlen, sst, sen = 0, 0, 0, 0, float("inf"), 0
        for row in rows:
            alen += int(row["alignment length"])
            gaps += int(row["gap opens"])
            mism += int(row["mismatches"])
            qlen = int(row["query length"])
            sstart, send = int(row["s. start"]), int(row["s. end"])
            sstart, send = (sstart, send) if sstart < send else (send, sstart)
            sst, sen = min(sst, sstart), max(sen, send)
        yield key, sst, sen, "plus" if sst < send else "minus", (alen - gaps - mism) / qlen * 100


def parse_argv(argv):
    parser = ArgumentParser(description="qpidcov", formatter_class=ArgumentDefaultsHelpFormatter,)

    parser.add_argument("file", type=FileType(), help="the file")

    args = parser.parse_args(argv)

    return args


def main(argv):
    args = parse_argv(argv[1:])

    with args.file as stream:
        print("accver", "start", "end", "strand", "qpidcov", sep="\t")
        for row in sorted(aggregate(stream), key=lambda row: -row[-1]):
            print(*row, sep="\t")

    return 0


if __name__ == "__main__":
    signal(SIGPIPE, SIG_DFL)
    sys.exit(main(sys.argv))
