import pandas as pd
import gensim
from gensim.utils import simple_preprocess
from gensim.parsing.preprocessing import STOPWORDS
from nltk.stem import WordNetLemmatizer, SnowballStemmer
from nltk.stem.porter import *
from sklearn.externals import joblib

def lemmatize_stemming(text):
    stemmer = PorterStemmer()
    return stemmer.stem(WordNetLemmatizer().lemmatize(text, pos='v'))
def preprocess(text):
    result = []
    for token in gensim.utils.simple_preprocess(text):
        if token not in gensim.parsing.preprocessing.STOPWORDS and len(token) > 3:
            result.append(lemmatize_stemming(token))
    return result

def predict(text):
    # Load pretrained LDA model
    dictionary = gensim.corpora.Dictionary.load('dictionary_Pizza.dict')
    lda_model_tfidf = gensim.models.LdaModel.load('LDA_model_Pizza')
    results = {1: [3.663569, '3.5-4.0'],2: [4.273510, '4.0-4.5'],3: [2.701229, '2.5-3.0'], 4: [4.222626, '4.0-4.5'],5: [2.848786, '2.5-3.0'],
            6: [4.655060, '4.5-5.0'],7: [3.753793, '3.5-4.0'],8: [2.159549, '2.0-2.5'], 9: [4.079343, '4.0-4.5'],10: [3.626087, '3.5-4.0'],
            'No': ['Invalid infromation!']}
    predition = pd.DataFrame(results,index=['Ave_star','range'])

    bow_vector = dictionary.doc2bow(preprocess(text))
    result = sorted(lda_model_tfidf[bow_vector], key=lambda tup: -1*tup[1])
    if len(result) != 1:
        if (result[0][1] == result[1][1]):
            index = 'No'
        else:
            index = result[0][0]+1
    else :
        index = result[0][0]+1
    return index,predition.loc['range'][index] 

