import sys
from collections import OrderedDict
from operator import itemgetter

def parse_log(stream):
    fields = []
    for line in map(str.strip, stream):
        if line.startswith("ModelFinder"):
            fields = next(stream).strip().split()
        if fields:
            tokens = line.split()
            if tokens[0].isdigit():
                yield OrderedDict(zip(fields, tokens))
            elif tokens[0] == "Akaike":
                break

with open(sys.argv[1]) as stream:
    min(parse_log(stream), key = itemgetter("BIC"))
