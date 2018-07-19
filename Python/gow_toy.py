import string
from nltk.corpus import stopwords

#import os
#os.chdir() # to change working directory to where functions live
# import custom functions
from library import clean_text_simple, terms_to_graph, unweighted_k_core

stpwds = stopwords.words('english')
punct = string.punctuation.replace('-', '')

my_doc = '''A method for solution of systems of linear algebraic equations 
with m-dimensional lambda matrices. A system of linear algebraic 
equations with m-dimensional lambda matrices is considered. 
The proposed method of searching for the solution of this system 
lies in reducing it to a numerical system of a special kind.'''

my_doc = my_doc.replace('\n', '')

# pre-process document
my_tokens = clean_text_simple(my_doc,my_stopwords=stpwds,punct=punct)
                              
g = terms_to_graph(my_tokens, w=4)
    
# number of edges
print len(g.es)

# the number of nodes should be equal to the number of unique terms
len(g.vs) == len(set(my_tokens))

edge_weights = []
for edge in g.es:
    source = g.vs[edge.source]['name']
    target = g.vs[edge.target]['name']
    weight = edge['weight']
    edge_weights.append([source, target, weight])

print edge_weights

for w in range(2,11):
    g = terms_to_graph(my_tokens, w)
    print g.density()
    
# decompose g
core_numbers = unweighted_k_core(g)
print core_numbers

# compare with igraph method
print dict(zip(g.vs["name"],g.coreness()))

# retain main core as keywords
max_c_n = max(core_numbers.values())
keywords = [kwd for kwd, c_n in core_numbers.iteritems() if c_n == max_c_n]
print keywords
