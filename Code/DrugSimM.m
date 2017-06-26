function S = DrugSimM(drugnum, DiSim)
% drug similarity matrix
% drugnum: the number of drugs
% DiSim: the similarity matrix of diseases

drugpair = load('drugpairlist.txt');
len_pair = length(drugpair)';
load('dis_drug');

S = zeros(drugnum);

for i = 1 : len_pair
    dr1 = drugpair(i,1);
    dr2 = drugpair(i,2);
    
    di1 = dis_drug{dr1};
    di2 = dis_drug{dr2};
    len1 = length(di1);
    len2 = length(di2);
    
    if len1 & len2
        disM = DiSim(di1, di2);
        
        s1 = calc_simM(disM, len1, len2);
        s2 = Jaccard_index(di1, di2);
        S(dr1, dr2) = sqrt(s1 * s2);
    end
end

% S = S + S';
% S = laplacian_norm(S);

        
        
        
