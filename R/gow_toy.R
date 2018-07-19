lapply(list('igraph','SnowballC','stringr','openNLP','hash','tm'), library, character.only=TRUE)

hide = lapply(list('clean_text.R','from_terms_to_graph.R','assign_attributes_to_graph_initial.R','tagPOS.R'), source)

# ==================

my_stops = readLines('stopwords_english.txt',encoding='UTF-8')

my_doc = 'A method for solution of systems of linear algebraic equations 
with m-dimensional lambda matrices. A system of linear algebraic 
equations with m-dimensional lambda matrices is considered. 
The proposed method of searching for the solution of this system 
lies in reducing it to a numerical system of a special kind.'

tl = clean_text(my_doc,my_stops,pos=T,do_stem=T)

# create graph with window of size 4
edges_df = from_terms_to_graph(tl, 4, overspan=T, processed=T)$output
gow = assign_attributes_to_graph_initial(edges_df, weighted=T, directed=FALSE)$g
plot(gow)
