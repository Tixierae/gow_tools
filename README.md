## What is this repository for?
This repo provides functions for creating and analyzing word co-occurrence networks in Python and R. Examples are provided in the `gow_toy` scripts.

## What are word co-occurrence networks?
To get a feel for what word co-occurrence networks are, what they can be used for, and the impact of the different parameters, have a look at this [interactive web app](https://safetyapp.shinyapps.io/GoWvis/) (GoWvis). You can paste your own text and download the graph edgelist.

In this repository, word co-occurrence networks are defined in the manner of [Mihalcea and Tarau (2004)](http://www.aclweb.org/anthology/W04-3252). Some more recent papers using word co-occurrence networks can be found below.

## Relevant literature
ACL 2018:
```
@inproceedings{shang2018unsupervised,
  title={Unsupervised Abstractive Meeting Summarization with Multi-Sentence Compression and Budgeted Submodular Maximization},
  author={Shang, Guokan and Ding, Wensi and Zhang, Zekun and Tixier, Antoine Jean-Pierre and Meladianos, Polykarpos and Vazirgiannis, Michalis and Lorr{\'e}, Jean-Pierre},
booktitle={Proceedings of the 2018 Conference of the Association for Computational Linguistics},
  year={2018}
}
```
[link](https://arxiv.org/pdf/1805.05271.pdf)

EMNLP 2016:
```
@inproceedings{tixier2016graph,
  title={A graph degeneracy-based approach to keyword extraction},
  author={Tixier, Antoine and Malliaros, Fragkiskos and Vazirgiannis, Michalis},
  booktitle={Proceedings of the 2016 Conference on Empirical Methods in Natural Language Processing},
  pages={1860--1870},
  year={2016}
}
```
[link](http://www.aclweb.org/anthology/D16-1191)
