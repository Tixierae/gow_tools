# to add on top of function file
sta = Maxent_Sent_Token_Annotator()
wta = Maxent_Word_Token_Annotator()
pta = Maxent_POS_Tag_Annotator()

clean_text = function(X, custom, pos, do_stem) {
    # required packages: "stringr","openNLP","SnowballC"
    # required functions: "tagPOS.R"

    # this function performs standard preprocessing steps
    # it returns both the unprocessed and processed tokenized text
    # the difference between the two lies in stopwords removal, POS screening (nouns and adjectives), and stemming
    # if none of these parameters has been set to TRUE by the user, then the unprocessed and processed character vectors are the same

    # make sure UTF-8 is used as the encoding
    x = enc2utf8(X)

    # remove extra white space
    x = gsub("\\s+"," ",x)
    # replace slashes and (backslashes followed by t) with white space
    x = gsub("[/\t]"," ",x)

    # split into sentences
    s = as.String(x)
    boundaries = annotate(s, sta)
    sentences = s[boundaries]

    # we will use Porter's stemmer
    language_stemmer = 'porter'

    # remove between word dashes
    x = gsub("- ", " ", x, perl = T) 
    x = gsub(" -", " ", x, perl = T)

    # remove parentheses
    x = gsub("\\(", " ", x, perl = T) 
    x = gsub("\\)", " ", x, perl = T)

    # remove punctuation but keep commas, semicolons, periods, exclamation marks, question marks, intra-word dashes and apostrophes (e.g., "I'd like")

    # the subset of the aforementioned punctuation marks corresponding to sentence stop signs will be used for graph building if overspan==FALSE

    x = gsub("[^[:alnum:][:space:],;.!?'-:]", " ", x)

    # remove plus and star signs
    x = gsub("+", " ", x, fixed = T)
    x = gsub("*", " ", x, fixed = T)

    # remove apostrophes that are not intra-word
    x = gsub("' ", " ", x, perl = T)
    x = gsub(" '", " ", x, perl = T)

    # collapse "I'd" into "Id"
    x = gsub("'", "", x, perl = T)

    # remove numbers (integers and floats) but not dates like 2015
    x = gsub("\\b(?!(?:18|19|20)\\d{2}\\b(?!\\.\\d))\\d*\\.?\\d+\\b"," ", x, perl=T)


    # remove "e.g." and "i.e."
    x = gsub("\\b(?:e\\.g\\.|i\\.e\\.)", " \\1 ", x, perl=T)

    # separate remaining punctuation from words,
    # differentiating between ellipsis (suspension points) and periods
    # punctuation marks are also separated from other marks (to ensure 1-to-1 matching with POS tags)
    x = gsub("[[:blank:]]*([.]{2,}|[.,:;!?])[[:blank:]]*", " \\1 ", x, perl=T)

    # replace "...." by "..."
    x = gsub("(\\.\\.\\.\\.)", " \\.\\.\\. ", x, perl=T)

    # replace ".." by "."
    x = gsub("(\\.\\.\\.)(*SKIP)(*F)|(\\.\\.)", " \\. ", x, perl=T)

    # replace slashes and (backslashes followed by t) with white space
    x = gsub("[/\t]"," ",x)

    # remove leading and trailing white space
    x = str_trim(x,"both")

    # remove extra white space
    x = gsub("\\s+"," ",x)

    # convert to lower case
    x = tolower(x)

    if (pos == T) {

    # tokenize
    x = unlist(strsplit(x,split=" "))
    # make a copy of tokens without further preprocessing
    xx = x

    # retain nouns, adjectives, and useful punctuation marks
    x_tagged = tagPOS(x)$output
    index = which(x_tagged%in%c("NN","NNS","NNP","NNPS","JJ","JJS","JJR",":",".",","))
    if (length(index)>0){
    x = x[index]
    }

    } else {

    # tokenize
    x = unlist(strsplit(x,split=" "))
    # make a copy of tokens without further preprocessing
    xx = x

    }

    # remove stopwords
    index = which(x %in% custom)
    if (length(index)>0){
    x = x[-index]
    }

    if (do_stem == T){
    x = wordStem(x, language = language_stemmer)
    xx = wordStem(xx, language = language_stemmer)
    }

    # remove blank elements
    index = which(x=="")
    if (length(index)>0){
    x = x[-index]
    }

    index = which(xx=="")
    if (length(index)>0){
    xx = xx[-index]
    }

    output = list(unprocessed=xx, processed=x, sentences=sentences)

}