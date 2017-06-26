% laplacian normalization of matrix
function M_norm = laplacian_norm(M)
n = length(M);
D = zeros(n, 1);
for i = 1 : n
    % sum of row
    D(i) = sum(M(i, :)); 
end

M_norm = zeros(n);
for i = 1 : n-1
    if D(i)
        for j = i+1 : n
            if D(j)
                M_norm(i,j) = M(i,j) / sqrt(D(i)*D(j));
            end
        end
    end
end
M_norm = M_norm + M_norm';
        