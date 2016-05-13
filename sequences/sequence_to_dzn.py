#!/usr/bin/python3

from os.path import basename
from os.path import splitext
import sys
import re
import logging

if len(sys.argv) < 2:
    print('To few arguments, please specify a filename')
    sys.exit()

number        = re.compile(r'\d+')
empty_line    = re.compile(r'^\s*$')
input_file    = sys.argv[1]
nlines        = 0
nsymbols      = 0
symbols_to_id = {}
id_to_symbols = {}
with open(input_file, 'r') as instance_file:
    lines      = (line for line in instance_file if not empty_line.match(line))

    for line in lines:
        for key in re.findall(number,line):
            if key not in symbols_to_id:
                symbols_to_id[key]      = nsymbols
                id_to_symbols[nsymbols] = key
                nsymbols += 1
        nlines += 1
instance_file.close()
print('{} {}'.format(nlines, nsymbols))
matrix = [[set() for j in range(nsymbols)] for i in range(nlines)]
with open(input_file, 'r') as instance_file:
    lines      = (line for line in instance_file if not empty_line.match(line))

    nline = 0
    for line in lines:
        npos = 1
        for key in re.findall(number,line):
            col = symbols_to_id[key]
            matrix[nline][col].add(npos)
            npos += 1
        nline += 1
instance_file.close()


set_to_str = lambda x: '{}' if len(x) == 0 else str(x)
output_file = splitext(basename(input_file))[0] + '.dzn'
with open(output_file, 'w') as output_file:
    output_file.write('p={};\n'.format(nlines))
    output_file.write('q={};\n'.format(nsymbols))
    output_file.write('m=[|\n')
    for row in matrix:
        output_file.write(','.join(map(set_to_str,row)) + '|\n')
    output_file.write('];')
output_file.close()
