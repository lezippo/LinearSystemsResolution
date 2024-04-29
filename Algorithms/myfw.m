function [x]=myfw(L,b)
% Purpose: solve systems with lower triangular associated matrix
% through the forward substitution algorithm (solve the first equation
% of the system, substitute in the second one, obtain x(2), substitute
% x(1) and x(2) in the third equation of the system, and so on)
%
% Syntax: [x]=myfw(L,b)
% Input:
% L:       matrix associated with the system. NOTE: L must be a lower triangular matrix
% b:       column vector of constant terms
% Output:
% x:       solution of the system Lx=b
%
% Example:
% A=[ 1, 0, 0; 2, 2, 0; 7, 2, 9];
% b=[1,4,18]';
%
% [x]=myfw(A,b)
%
% Author: Luigi Emanuele Zippo

n=length(b);
x=zeros(n,1);

% Obtain x(1) from the first equation of the system

x(1)=b(1)/L(1,1);

for k=2:n

    x(k)=b(k);

    for j=1:(k-1)

        x(k)=x(k)-L(k,j)*x(j);

    end

    x(k)=x(k)/L(k,k);


end
