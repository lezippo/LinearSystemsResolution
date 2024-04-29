function [x]=myfwsistemi(L,b)
% Purpose: solve systems with lower triangular associated matrix and unit diagonal
% through the forward substitution algorithm (solve the first equation
% of the system, substitute in the second one, obtain x(2), substitute
% x(1) and x(2) in the third equation of the system, and so on). The algorithm
% is designed for solving systems using LU factorization.
%
% Syntax: [x]=myfwsistemi(L,b)
% Input:
% L:       matrix associated with the system. NOTE: L must be a lower triangular matrix with unit diagonal
% b:       column vector of known terms
% Output:
% x:       solution of the system Lx=b
%
% Example:
% A=[ 1, 0, 0; 2, 1, 0; 7, 2, 1];
% b=[ 1, 4, 18]';
%
% [x]=myfwsistemi(A,b)
%
% Author: Luigi Emanuele Zippo
n=length(b);
x=zeros(n,1);

x(1)=b(1);

for k=2:n

    x(k)=b(k);

    for j=1:(k-1)

        x(k)=x(k)-L(k,j)*x(j);

    end
 
%     We removed the line x(k)=x(k)/L(k,k) because, in LU factorization,
%     the diagonal is occupied by elements of U while the diagonal of L
%     is formed by all 1s.

end
