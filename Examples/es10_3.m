r=[ 1  1  1  2  2  2  3  3  3 ];
c=r;
a=[ 1 -2  2 -1  1 -1 -2 -2  1 ];

% observing the matrix, we notice that it satisfies the conditions of the Stein-Rosenberg Theorem (positive elements on the main diagonal, all other elements null or negative)

b=[ 1
   -1
    3 ];

x0=zeros(3,1);
x0=sparse(x0);
tol=10^-3;
kmax=100;

[x,ierr]=myj(a,r,c,b,x0,kmax,tol)
[x,ierr]=mygs(a,r,c,b,x0,kmax,tol)

% Both methods converge. Due to the Stein-Rosenberg theorem: Gauss-Seidel converges faster, or Jacobi and Gauss-Seidel converge at the same "speed" (maximum or minimum)

% error

hold on

[x,ierr,errj,kj]=myjerr(a,r,c,b,x0,kmax,tol);
[x,ierr,errgs,kgs]=mygserr(a,r,c,b,x0,kmax,tol);

plot(kj,errj,'m',kgs,errgs,'b')
plot([0,max(kj)],[tol,tol],'k--')
legend('Jacobi','Gauss-Seidel','Tolerance')

% As we can observe, they converge at the same speed, within a single iteration







