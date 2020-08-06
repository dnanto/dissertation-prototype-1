#!/usr/bin/env python3

import sys
from argparse import ArgumentDefaultsHelpFormatter, ArgumentParser, FileType
from csv import DictReader, DictWriter, Sniffer
from csv import reader as ListReader
from csv import writer as ListWriter
from datetime import datetime
from operator import itemgetter
from signal import SIG_DFL, SIGPIPE, signal


def normalize_date(val, formats, to_fmt="%Y-%m-%d", na_val=None):
    result = na_val
    for fmt in formats:
        try:
            result = datetime.strptime(val, fmt).strftime(to_fmt)
        except:
            pass
        if result != na_val:
            break
    return result


def process_rows(rows, cols, formats, to_fmt="%Y-%m-%d", na_val=None):
    for row in rows:
        for col in cols:
            row[col] = normalize_date(row[col], formats, to_fmt, na_val)
        yield row


def parse_argv(argv):
    parser = ArgumentParser(
        description="date normalizer", formatter_class=ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument("file", type=FileType(), help="the file")
    parser.add_argument("-fo", default="%Y-%m-%d", help="the output format")
    parser.add_argument("-fi", nargs="+", required=True, help="the input formats to try")
    parser.add_argument("-unknown", default="", help="the value to use if format unknown")
    parser.add_argument("-columns", nargs="+", required=True, help="the columns to normalize")
    parser.add_argument("-header", action="store_true", help="the flag to use the file header")
    parser.add_argument("-delimiter", default="\t", help="the delmiter to use, otherwise sniff")

    args = parser.parse_args(argv)

    return args


def main(argv):
    args = parse_argv(argv[1:])

    with args.file as stream:
        if args.header:
            reader, writer = DictReader, DictWriter
            fieldnames = next(stream).strip().split(args.delimiter)
            kwargs = dict(delimiter=args.delimiter, fieldnames=fieldnames)
        else:
            reader, writer = ListReader, ListWriter
            args.columns = list(map(int, args.columns))
            kwargs = dict(delimiter=args.delimiter)

        writer(sys.stdout, **kwargs).writerows(
            process_rows(reader(stream, **kwargs), args.columns, args.fi, args.fo, args.unknown)
        )

    return 0


if __name__ == "__main__":
    signal(SIGPIPE, SIG_DFL)
    sys.exit(main(sys.argv))
