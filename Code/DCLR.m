drugnum = 308;
comb = load('drugcomb.txt');
load('neg_samples');
drugpair = load('drugpairlist.txt');

% drug similarity score
load('DrugSimM');
DrugSimM = DrugSimM + DrugSimM';
DrugSimM = laplacian_norm(DrugSimM);

% known comb Matrix
len_comb = length(comb);
combM = zeros(drugnum);
for i = 1 : len_comb
    combM(comb(i,1), comb(i,2)) = 1;
end
combM = combM + combM';

neg = neg_samples;
samples = [comb; neg];  % select current samples
len_samples = length(samples);
y_prim = [ones(len_comb,1); zeros(length(neg),1)]; % true targets

% load prob score
pred_prob = load(pred_prob_files);
output_index = load(output_index_name);
len_index = length(output_index);

load('syn_drug');
M1 = DrugSimM;

M2 = zeros(drugnum);

for i = 1 : len_samples
    dr1 = samples(i,1);
    dr2 = samples(i,2);
    
    syn1 = syn_drug{dr1};
    syn2 = syn_drug{dr2};
    len1 = length(syn1);
    len2 = length(syn2);
    
    if len1
        for d = 1 : len1
            index = find(output_index == dr1);
            if isempty(index) == 0
                k = syn1(d);
                if k ~= dr2
                    if k > dr2
                        temp1 = dr2;
                        temp2 = k;
                    else
                        temp1 = k;
                        temp2 = dr2;
                    end
                    
                    loc1 = find(drugpair(:,1) == temp1);
                    loc2 = find(drugpair(:,2) == temp2);
                    loc = intersect(loc1, loc2);
                    M2(dr1, dr2) = M2(dr1, dr2) + pred_prob(loc, index);
                end
            end
        end
    end
    
    if len2
        for d = 1 : len2
            index = find(output_index == dr2);
            if isempty(index) == 0
                k = syn2(d);
                if k ~= dr1
                    if k > dr1
                        temp1 = dr1;
                        temp2 = k;
                    else
                        temp1 = k;
                        temp2 = dr1;
                    end
                    loc1 = find(drugpair(:,1) == temp1);
                    loc2 = find(drugpair(:,2) == temp2);
                    loc = intersect(loc1, loc2);
                    if isempty(loc) == 0
                        M2(dr1, dr2) = M2(dr1, dr2) + pred_prob(loc, index);
                    end
                end
            end
        end
    end
end

M2 = M2 + M2';
M2 = laplacian_norm(M2);
alpha1 = 0.8;
alpha2 = 0.2;
S = alpha1 * M1 + alpha2 * M2;

y_hat = zeros(len_samples, 1);
for i = 1 : len_samples
    y_hat(i) = S(samples(i,1), samples(i,2));
end
