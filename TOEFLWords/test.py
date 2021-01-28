import json
from os import name

pre_vocab = json.load(open('toefl_vocab.json'))
vocab = []

print(len(pre_vocab))
ids = [v['id'] for v in pre_vocab]
exists = []

for i in range(len(pre_vocab)):
    res = {}
    word = pre_vocab[i]
    
    if word['id'] in exists:
        continue
    exists.append(word['id'])

    res['id'] = word['id']
    res['definition'] = word['defination']
    res['additional'] = word['additional']
    res['relation'] = word['relation']
    res['sentences'] = word['sentences']

    vocab.append(res)

print(len(vocab))

json.dump(vocab, open('toefl_vocab_2.json', 'w'), ensure_ascii=False)
