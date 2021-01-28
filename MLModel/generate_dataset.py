import json
import numpy as np
from tqdm import tqdm
from numpy.core import numeric
from pandas import DataFrame

vocab = json.load(open('toefl_vocab.json'))
vocab = [ word['id'] for word in vocab ]
print(len(vocab))

num_users = 100
num_words = len(vocab)

user_lst = []
word_lst = []
rating_lst = []

for i in tqdm(range(num_users)):
    num_read = np.random.randint(50, 1000)
    idx = np.random.choice(num_words, size=num_read)
    words = [ vocab[i] for i in idx ]
    ratings = np.random.exponential(5, size=num_read)
    user_lst += [f'User_{i}'] * num_read
    word_lst += words
    rating_lst += [ int(num) for num in ratings.tolist() ]

df = DataFrame({
    'user': user_lst,
    'word': word_lst,
    'rating': rating_lst
})

df.to_csv('./dataset.csv', index=False)
