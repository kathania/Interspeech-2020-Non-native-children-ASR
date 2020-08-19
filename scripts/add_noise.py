__author__ = "Mittul Singh"
__copyright__ = "Copyright (c) 2020, Aalto Speech Research"

import time
import numpy as np
import argparse
import sys, os

def main(args):
    with open(args.text_file,'r') as f:
        for line in f:
            for word in line.split():
                if len(word) > args.min_word_length and not any(not c.isalnum() for c in word):
                    # decide to split based on threshold
                    rnum = np.random.uniform(0, 1)

                    if rnum > args.threshold:
                        # choose a randome index of the word to perform the split
                        ridx = np.random.randint(1, len(word)-1)
                        sys.stdout.write(word[:ridx] + '- ' + word + ' ')
                    else:
                        sys.stdout.write(word + ' ')
                else:
                    sys.stdout.write(word + ' ')
            sys.stdout.write('\n')
                        

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Add text noise')
    parser.add_argument('--text-file', default='data/lm_train/TLTtrain.txt',
                    help='Flag to input the text file')
    parser.add_argument('--min-word-length', default=3, type=int,
                    help='minimum word length to create a partial word (at least 3)')
    parser.add_argument('--threshold', default=0.5, type=float,
                    help='threshold to split a word in to a partial word')

    args = parser.parse_args()

    main(args)

