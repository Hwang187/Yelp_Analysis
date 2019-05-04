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
    dictionary = gensim.corpora.Dictionary.load('dictionary_Desserts.dict')
    lda_model_tfidf = gensim.models.LdaModel.load('LDA_model_Desserts')
    results = {1: [3.999268, '3.5-4.0'],2: [4.321903, '4.0-4.5'],3: [4.254815, '4.0-4.5'], 4: [4.211060, '4.0-4.5'],5: [4.135504, '4.0-4.5'],
        6: [2.317142, '2.0-2.5'],7: [4.599073, '4.5-5.0'],8: [3.696830, '3.5-4.0'],9: [4.219595, '4.0-4.5'], 10: [3.991448, '3.5-4.0'],
        11: [4.510145, '4.5-5.0'],12: [4.510145, '4.5-5.0'],13: [3.956703, '3.5-4.0'], 14: [4.211573, '4.0-4.5'],15: [4.371436, '4.0-4.5'],
        16: [3.971007, '3.5-4.0'],'No': ['Invalid infromation!']}
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
