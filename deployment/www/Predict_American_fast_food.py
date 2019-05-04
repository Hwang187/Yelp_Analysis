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
    dictionary = gensim.corpora.Dictionary.load('dictionary_American_fast_food.dict')
    lda_model_tfidf = gensim.models.LdaModel.load('LDA_model_American_fast_food')
    results = {1: [4.009749, '4.0-4.5'],2: [4.247558, '4.0-4.5'],3: [3.763237, '3.5-4.0'], 4: [4.585623, '4.5-5.0'],5: [3.961807, '3.5-4.0'],
        6: [3.967921, '3.5-4.0'],7: [3.285122, '3.0-3.5'],8: [4.003139, '4.0-4.5'], 9: [3.884530, '3.5-4.0'],10: [4.565119, '4.5-5.0'],
        11: [3.959232, '3.5-4.0'],12: [4.480636, '4.0-4.5'],13: [3.782438, '2.5-3.0'], 14: [4.648048, '4.0-4.5'],15: [4.205085, '2.5-3.0'],
        16: [3.980668, '3.5-4.0'],17: [1.900298, '1.5-2.0'],'No': ['Invalid infromation!']}
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

