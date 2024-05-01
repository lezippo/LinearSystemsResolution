r=[ 1  1  2  2  2  3  3  4  4  5  5 ];
c=[ 1  2  1  2  4  1  3  4  5  4  5 ];
a=[ 6 -1 -5 10 -1 -1 20 14 -2 -3  8 ];

% the matrix satisfies the conditions of the Stein-Rosenberg Theorem

b=[ 2
    4
    1
    3
    5 ];

x0=zeros(5,1);
x0=sparse(x0);
tol=10^-6;
kmax=100;

[x,ierr]=myj(a,r,c,b,x0,kmax,tol)
[x,ierr]=mygs(a,r,c,b,x0,kmax,tol)

% Both methods converge. Due to the Stein-Rosenberg theorem: Gauss-Seidel converges faster, or Jacobi and Gauss-Seidel converge at the same "speed" (maximum or minimum)

hold on

[x,ierr,errj,kj]=myjerr(a,r,c,b,x0,kmax,tol);
[x,ierr,errgs,kgs]=mygserr(a,r,c,b,x0,kmax,tol);

plot(kj,errj,'m',kgs,errgs,'b')
plot([0,max(kj)],[tol,tol],'k--')
legend('Jacobi','Gauss-Seidel','Tolleranza')

% In this case, Gauss-Seidel is faster
