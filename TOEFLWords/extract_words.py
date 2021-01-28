import json
from copy import deepcopy
from tqdm import tqdm

words_lst = open('wangyumei-toefl-words.txt').readlines()
words_lst = [line.strip() for line in words_lst if len(line.strip()) > 0]

words_lst = [line.split('#')[0] for line in words_lst]
words_lst = list(set(words_lst))
with open('raw_vocab.json', 'w') as f:
    json.dump(words_lst, f, ensure_ascii=False)
