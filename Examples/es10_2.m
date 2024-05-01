r=[ 1  1  2  2  3  3  3  4  4  5  5  5 ];
c=[ 1  3  2  5  2  3  4  4  5  1  2  5 ];
a=[ 2  4  3  5  1 -1  3 -2  3  1  3  5 ];

A=sparse(r,c,a);

b=[ 1
    2
    6
   -17
    2 ];

b=sparse(b);

x0=zeros(5,1);
x0=sparse(x0);
tol=10^-3;
kmax=100;

[x,ierr]=myj(a,r,c,b,x0,kmax,tol)
[x,ierr]=mygs(a,r,c,b,x0,kmax,tol)

% both methods do not converge

% error

hold on

[x,ierr,errj,kj]=myjerr(a,r,c,b,x0,kmax,tol);
[x,ierr,errgs,kgs]=mygserr(a,r,c,b,x0,kmax,tol);

plot(kj,errj,'m',kgs,errgs,'b')
plot([0,max(kj)],[tol,tol],'k--')
legend('Jacobi','Gauss-Seidel','Tolerance')

