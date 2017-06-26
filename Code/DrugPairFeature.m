function [feature, output] = DrugPairFeature(drugnum, disnum, neg, ddMat, syn_drug)
% drugnum: the number of drugs
% disnum: the number of diseases
% neg: negative samples
% ddMat: drug-disease association matrix
% syn_drug: synergistic drugs for every drugs
% return the feature of drug pairs (feature) and the corresponding output (y)

ncol = 2 + 2 * disnum;
neg = neg_samples;
samples = [comb; neg];
len_samples = length(samples);
feature = zeros(len_samples, ncol);
y_prim = zeros(len_samples, drugnum);
% calculate feature of drug pairs
for k = 1 : len_samples
    
    dr1 = samples(k,1);
    dr2 = samples(k,2);
    syn_drug1 = syn_drug{dr1};
    syn_drug2 = syn_drug{dr2};
    cosyn = intersect(syn_drug1, syn_drug2);
    len_co = length(cosyn);
    
    
    if len_co
        for i = 1 : len_co
            y_prim(k, cosyn(i)) = 1;
        end
    end
    
    D1 = ddMat(dr1, :);
    D2 = ddMat(dr2, :);
    
    feature(k,:) = [dr1, dr2, D1, D2];

end

    
% delete all_zero cols in y_prim
not_zero = [];
for k = 1 : drugnum
    if length(find(y_prim(:, k) == 1))
        not_zero = union(not_zero, k);
    end
end
output = y_prim(:, not_zero);


