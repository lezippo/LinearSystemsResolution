function [x]=mybw(U,b)
% Purpose: solve systems with upper triangular associated matrix
% through the backward substitution algorithm (solve the last equation
% of the system, substitute in the penultimate one, obtain x(n-1), substitute
% x(n) and x(n-1) in the third last equation of the system, and so on)
% Syntax: [x]=mybw(U,b)
% Input:
% U:       matrix associated with the system. NOTE: U must be an upper triangular matrix
% b:       column vector of constant terms
% Output:
% x:       solution of the system Ux=b
%
% Example:
% U=[1, 2, 7; 0, 2, 2; 0, 0, 9];
% b=[10, 4, 9];
%
% [x]=mybw(U,b)
%
% Author: Luigi Emanuele Zippo

n=length(b);
x=zeros(n,1);

% Obtain x(n) from the last equation of the system

x(n)=b(n)/U(n,n);

for k=(n-1):-1:1

    x(k)=b(k);

    for j=k+1:n

        x(k)=x(k)-U(k,j)*x(j);

    end

    x(k)=x(k)/U(k,k);

end
