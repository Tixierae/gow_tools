tagPOS = function(char){
	# part-of-speech tagger based on openNLP Apache
	# required package: "openNLP"
	s = as.String(char)
	a = annotate(s, list(sta, wta))
	aa = annotate(s, pta, a)
	output = list(output = unlist(lapply(aa[aa$type=="word"]$features, `[[`, "POS")))
}