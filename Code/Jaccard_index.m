function y = Jaccard_index(A, B)

len_co = length(intersect(A, B));
y = len_co / (length(A) + length(B) - len_co);