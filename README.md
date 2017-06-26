# DCLR
synergistic drug combinations prediction model

1.Dataset.

DiSimMat store disease similarity matrix;

DrugDis and drug_disease_label store known disease-drug association information;

DrugsID and DisID store drug ids (DCDB) and disease ids (OMIM), respectively;

DrugComb stores approved drug combinations;

drugpairlist stores all possible drug pairs in labels;

DrugSimM.mat stores drug similarity matrix;

dis_drug.mat stores the disease sets for every drug; syn_drug.mat stores the synergistic drugs for every drug;

neg_samples.mat stores the negative samples.

2.Code.

calc_simM.m: function implementing between matrix M and V, which has the same dimension with all its elements equal to 1;

Jaccard_index.m: function implementing Jaccard similarity coefficient;

laplacian_norm.m: function implementing normalization;

DrugSimM.m: function implementing similarity between drugs;

DrugPairFeature.m: function implementing feature vectors of drug pairs;

Likelihood of sharing synergies.py: calculating shared synergies likelihood between drugs;

DCLR: scoring system of synergism.
