% The inverse of a matrix can be seen as the solution of the system A*X=I

A=[ 2  0  1  2
    1  1  0  2  
    2 -1  3  1 
    3 -1  4  3 ];

disp(A);
n=size(A,2);
B=eye(n);
x=zeros(n,n);

[A,info]=mylu(A);

disp('info =')
disp(info)

for k=1:n

y=myfwsistemi(A,B(:,k));
[x(:,k)]=mybw(A,y);

end

disp('Matrice inversa =')
disp(x)





