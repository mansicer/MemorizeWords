import json
from os import name

pre_vocab = json.load(open('vocab.json'))
vocab = []

relation_set = []
sentences_set = []

def getordefault(dic, key, default=[]):
    if key in dic:
        return dic[key]
    else:
        return default

print(len(pre_vocab))

for i in range(len(pre_vocab)):
    res = {}
    word = pre_vocab[i]
    relation_set.extend(list(word['relation'].keys()))
    sentences_set.extend(list(word['sentences'].keys()))
    
    relation_set = list(set(relation_set))
    sentences_set = list(set(sentences_set))

    res['id'] = word['word']
    res['definition'] = word['definition']
    res['additional'] = word['additional_definition']
    res['relation'] = word['relation']
    res['sentences'] = word['sentences']

    vocab.append(res)

print(relation_set)
print(sentences_set)

json.dump(vocab, open('toefl_vocab.json', 'w'), ensure_ascii=False)
