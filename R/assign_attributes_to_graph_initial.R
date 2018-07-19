assign_attributes_to_graph_initial = function(edges_df, weighted, directed){
  
  # this function takes as input a directed edge list and creates an (un)directed (un)weighted graph from it
  
    if (directed==FALSE){
	
  # remove edges that would be the same if direction was not taken into account
  # (summing up their weights)
  
  edges_df_sorted = t(apply(edges_df[,1:2], 1, sort))
  index_duplicated = which(duplicated(edges_df_sorted))
  
  if (length(index_duplicated)>0){
  
  edges_df_und = edges_df_sorted[-index_duplicated,]
  
  } else {
    
    edges_df_und = edges_df_sorted
    
  }
  
  edges_df_und = cbind(edges_df_und,rep(0, nrow(edges_df_und)))
  
  for (r in 1:nrow(edges_df_und)){
    start = edges_df_und[r,1]
    end = edges_df_und[r,2]
    # we search the sorted edgelist to make sure we have sound row matches
    # we finally pull up the row of the initial edgelist with the weight as third column
    sum_weights = sum(as.numeric(edges_df[(edges_df_sorted[,1]==start)&(edges_df_sorted[,2]==end),3]))
    edges_df_und[r,3] = sum_weights
  }
    
	colnames(edges_df_und) = c("from","to","weight")
	  
      edges_df = edges_df_und
      
    }
    
    if (weighted == TRUE){
      
      # keep edge weights and add labels
      g = graph.data.frame(edges_df, directed=directed)
      E(g)$label = as.character(E(g)$weight)
      
    } else {
      
      # discard "weight" attribute (the third column), and don't assign labels
      g = graph.data.frame(edges_df[,1:2], directed=directed)
      
    }
    
    v_g_name = V(g)$name
    l_v_g_name = length(v_g_name)
    
    output = list(g=g, v_g_name=v_g_name, l_v_g_name=l_v_g_name, directed=directed, weighted=weighted, edges_df=edges_df)
    
}