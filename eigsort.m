% [Vsort,Dsort] = eigsort(V,D)
%
% Sorts a matrix eigenvectors and a matrix of eigenvalues in order 
% of eigenvalue size, largest eigenvalue first and smallest eigenvalue
% last.
%
% Example usage:
% [V,D] = eig(A);
% [Vnew,Dnew] = eigsort(V,D);
%
% Tim Marks 2002

function [Vsort,Dsort] = eigsort(V,D);
eigvals = diag(D);

% Sort the eigenvalues from largest to smallest. Store the sorted
% eigenvalues in the column vector lambda.
[lohival,lohiindex] = sort(eigvals);
lambda = flipud(lohival);
index = flipud(lohiindex);
Dsort = diag(lambda);

% Sort eigenvectors to correspond to the ordered eigenvalues. Store sorted
% eigenvectors as columns of the matrix vsort.
M = length(lambda);
Vsort = zeros(M,M);
for i=1:M
  Vsort(:,i) = V(:,index(i));
end;


