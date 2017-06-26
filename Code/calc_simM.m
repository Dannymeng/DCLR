function simvalue = calc_simM(M, n1, n2)
% sim between matrix M and N
% M: n1 * n2
% N: ones(n1*n2)
t = n1 * n2;
v = zeros(t, 1);
k = 1;
for i = 1 : n1
    for j = 1 : n2
        v(k) = M(i, j);
        k = k + 1;
    end
end
N = ones(t,1);
if norm(v) & norm(N)
    simvalue = dot(v, N) / norm(v) / norm(N);
else
    simvalue = 0;
end

