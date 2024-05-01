r=[  1  1  2  2  3  3  4  4  5  5  5  6  6  6  ];
c=[  1  5  1  2  3  5  1  4  1  3  5  1  2  6  ];
a=[ -9  1  2 -8 -7  1  3  4 -1 -1  6  2  3  10 ];

% The matrix A is strictly diagonally dominant: this implies that both the Jacobi and Gauss-Seidel methods converge.

b= [ -9
      2
      0
      3
     -1
      2 ];

b=sparse(b);

x0=zeros(6,1);
x0=sparse(x0);
tol=10^-6;
kmax=100;

[x,ierr]=myj(a,r,c,b,x0,kmax,tol)
[x,ierr]=mygs(a,r,c,b,x0,kmax,tol)

% errore

hold on

[x,ierr,errj,kj]=myjerr(a,r,c,b,x0,kmax,tol);
[x,ierr,errgs,kgs]=mygserr(a,r,c,b,x0,kmax,tol);

plot(kj,errj,'m',kgs,errgs,'b')
plot([0,11],[tol,tol],'k--')
legend('Jacobi','Gauss-Seidel','Tolerance')
