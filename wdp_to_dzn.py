#!/usr/bin/python3

from os.path import basename
from os.path import splitext
import sys
import re
import logging

if len(sys.argv) < 2:
    print('To few arguments, please specify a filename')
    sys.exit()

input_file = sys.argv[1]
with open(input_file, 'r') as instance_file:
    empty_line = re.compile(r'^\s*(%.*)?$')
    lines      = (line for line in instance_file if not empty_line.match(line))

    try:
        goods = int(next(lines).split(' ')[1])
        bids  = int(next(lines).split(' ')[1])
        dummy = int(next(lines).split(' ')[1])

        goods = goods + dummy

        number       = re.compile(r'\d+')
        transactions = [[0 for x in range(goods)] for y in range(bids)]
        costs        = [0 for x in range(bids)]
        floats       = [0 for x in range(bids)]
        max_float    = 0;
        for line in lines:
            line = line.split('\t', 2)
            bid  = int(line[0])
            cost = line[1];
            cost = cost.split('.')
            if len(cost) == 1:
                costs[bid] = int(cost[0])
            else:
                floats[bid] = len(cost[1])
                max_float   = max(max_float, floats[bid])
                costs[bid]  = int(''.join(cost))
            for val in re.findall(number,line[2]):
                val = int(val)
                transactions[bid][val] = 1
        for bid in range(bids):
            costs[bid] = costs[bid]*pow(10,max_float-floats[bid])
    except StopIteration:
        logging.error('All lines are empty')
    except ValueError:
        logging.error('Parse Error')
    except IndexError:
        logging.error('Index error')
instance_file.close()

output_file = splitext(basename(input_file))[0] + '.dzn'
with open(output_file, 'w') as output_file:
    output_file.write('goods={};\n'.format(goods))
    output_file.write('bids={};\n'.format(bids))
    output_file.write('costs=[{}];\n'.format(','.join(map(str,costs))))
    output_file.write('transactions=[')
    for transaction in transactions:
        output_file.write('|' + ','.join(map(str,transaction)) + '\n')
    output_file.write('|];')
output_file.close()
