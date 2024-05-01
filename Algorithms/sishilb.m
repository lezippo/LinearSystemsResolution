function x=sishilb(n)
% purpose: generate Hilbert matrix A of size n and solve the associated system of equations Ax=b, where b's elments are the sum of the elements of A in the corresponding row
%
% syntax x=sishilb(n)
% input:
% n: size of the Hilbert matrix
% output:
% x: solution to the system Ax=b

A=hilb(n);
b=zeros(n,1);

for i=1:n

    for j=1:n

    b(i)=b(i)+A(i,j);

    end

end

[A,p,info]=myplufatt(A);


y=myfwsistemi(A,b(p));
x=mybw(A,y);

end
