import requests
import json
import time
import random

from lxml import etree
from tqdm import tqdm
from copy import deepcopy

input_vocab_path = './raw_vocab.json'
output_vocab_path = './vocab.json'
words_lst = json.load(open(input_vocab_path))
print(f'Reading Vocab Size {len(words_lst)}')

stop_words = [
    '以上来源于', '网络'
]

word_format = {
    'word': NotImplementedError,
    'definition': [],
    'additional_definition': {},
    'relation': {},
    'sentences': {}
}

def filter_text_lst(lst):
    return [ item.strip() for item in lst if len(item.strip()) > 0 and item.strip() not in stop_words ]

vocab = []
failed_word = []

for word in tqdm(words_lst):
    request_url = f'https://dict.youdao.com/w/eng/{word}'
    req = requests.get(request_url, timeout=20)

    if req.status_code != 200:
        print(f'Error: Request word {word} Failed with status {req.status_code}')
        failed_word.append(word)
        continue
    
    text = req.text
    html = etree.HTML(text)
    word_dic = deepcopy(word_format)
    word_dic['word'] = word

    # definition
    definition = html.xpath('//*[@id="phrsListTab"]/div[@class="trans-container"]')
    if len(definition) != 1:
        print(f'Error: Get definition of word {word} failed! {definition}')
        failed_word.append(word)
        continue
    definition = definition[0]

    meaning = definition.xpath('.//li/text()')
    if len(meaning) == 0:
        print(f'Error: Word {word} has no meanings! ')
        failed_word.append(word)
        continue
    word_dic['definition'] = meaning

    additional = definition.xpath('.//p[@class="additional"]/text()')
    if len(additional) > 1:
        print(f'Error: Word {word} has strange additional definition term {additional} with length {len(additional)}')
        failed_word.append(word)
        continue
    additional_dic = {}
    if len(additional) == 1:
        additional = additional[0][1:-1].strip()
        additional_lst = additional.split('\n')
        additional_lst = filter_text_lst(additional_lst)
        if len(additional_lst) % 2 != 0:
            print(f'Error: Word {word} has strange additional definition term {additional}')
            failed_word.append(word)
            continue
        for i in range(len(additional_lst) // 2):
            additional_dic[additional_lst[2 * i]] = additional_lst[2 * i + 1]
    word_dic['additional_definition'] = additional_dic

    # words relation
    relation_dic = {}
    relation_title = html.xpath('//*[@id="eTransform"]/h3/span/a//text()')
    relation_title = filter_text_lst(relation_title)
    if len(relation_title) > 0:
        relation = html.xpath('//*[@id="transformToggle"]/div')
        if len(relation_title) != len(relation):
            print(f'Error: Word {word} relation not matched, relation title: {relation_title}, len {len(relation_title)}, relation content len {len(relation)}')
            failed_word.append(word)
            continue
        for i in range(len(relation)):
            div = relation[i]
            relation_text = div.xpath('.//text()')
            relation_text = filter_text_lst(relation_text)
            relation_dic[relation_title[i]] = relation_text
    word_dic['relation'] = relation_dic

    # sentences reference
    sentences_dic = {}
    sentences_title = html.xpath('//*[@id="examples"]/h3/span/a//text()')
    sentences_title = filter_text_lst(sentences_title)
    if len(sentences_title) > 0:
        sentences = html.xpath('//*[@id="examplesToggle"]/div')
        if len(sentences_title) != len(sentences):
            print(f'Error: Word {word} relation not matched, relation title: {sentences_title}, len {len(sentences_title)}, relation content len {len(sentences)}')
            failed_word.append(word)
            continue
        for i in range(len(sentences)):
            div = sentences[i]
            li_lst = div.xpath('.//li')
            if len(li_lst) == 0:
                print(f'Error: Word {word} has sentence region {sentences_title[i]} but corresponding `li` not found!')
                failed_word.append(word)
                continue
            sentences_lst = []
            for li in li_lst:
                p_lst = li.xpath('./p')
                if len(p_lst) == 0:
                    print(f'Error: Word {word} has sentence region {sentences_title[i]} with but sentences not found!')
                    failed_word.append(word)
                    continue
                p_text_lst = []
                for p in p_lst:
                    p_text = p.xpath('.//text()')
                    p_text = ''.join(p_text).strip()
                    p_text_lst.append(p_text)
                p_text_lst = filter_text_lst(p_text_lst)
                sentences_lst.append(p_text_lst)
            sentences_dic[sentences_title[i]] = sentences_lst
    word_dic['sentences'] = sentences_dic

    vocab.append(word_dic)

    time.sleep(random.random() / 5)

print(f'{len(failed_word)} words failed! ')
print('Failed words: ')
print(failed_word)
print('Saving vocab list...')
with open(output_vocab_path, 'w') as f:
    json.dump(vocab, f, ensure_ascii=False)
