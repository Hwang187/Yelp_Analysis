import pandas as pd
from gensim.utils import simple_preprocess
from gensim.parsing.preprocessing import STOPWORDS
from nltk.stem import WordNetLemmatizer, SnowballStemmer
from nltk.stem.porter import *
from gensim import corpora, models
np.random.seed(2018)
import nltk
nltk.download('wordnet')

'''
Write function to lemmatize and stemming review
Inside the function, also include remove stopwords and clean up test
'''
def lemmatize_stemming(text):
    stemmer = PorterStemmer()
    return stemmer.stem(WordNetLemmatizer().lemmatize(text, pos='v'))
def preprocess(text):
    result = []
    for token in gensim.utils.simple_preprocess(text):
        # remove stopwords and clean up text
        if token not in gensim.parsing.preprocessing.STOPWORDS and len(token) > 2:
            result.append(lemmatize_stemming(token))
    return result


# Generate dictionary and bow_corpus
def generate_dictionary_corpus(reviews_doc):
    processed_docs = reviews_doc['text'].map(preprocess)
    dictionary = gensim.corpora.Dictionary(processed_docs)
    # remove extreme words
    dictionary.filter_extremes(no_below=15, no_above=0.8)
    bow_corpus = [dictionary.doc2bow(doc) for doc in processed_docs]
    return(processed_docs, dictionary, bow_corpus)
