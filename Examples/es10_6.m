tol=5*10^-6;
kmax=2200;
format short
l=[10,20,40];

for k=1:3
    n=l(k);

    disp('Per n=')
    disp(n)

A=zeros(n);
b=ones(n,1);
x0=zeros(n,1);

r1=1:n;
r2=1:(n-1);
r3=2:n;
r=[r1 r2 r3];
c=[r1 r3 r2];
r1=ones(1,n);
r2=ones(1,n-1);
a=[2*r1 -r2 -r2];

% The matrix A is tridiagonal

disp('Jacobi')
[x,ierr]=myj(a,r,c,b,x0,kmax,tol)

disp('Gauss-Seidel')
[x,ierr]=mygs(a,r,c,b,x0,kmax,tol)

% errore

[x,ierr,errj,kj]=myjerr(a,r,c,b,x0,kmax,tol);
[x,ierr,errgs,kgs]=mygserr(a,r,c,b,x0,kmax,tol);

figure(k)
hold on
plot(kj,errj,'m',kgs,errgs,'b')
plot([0,max(kj)],[tol,tol],'k--')
legend('Jacobi','Gauss-Seidel','Tolerance')


end

% We notice that the matrix satisfies the conditions of the Stein-Rosenberg
% theorem (positive elements on the main diagonal, all other elements null
% or negative). Indeed, as we can observe from the graphs, Gauss-Seidel
% converges faster
