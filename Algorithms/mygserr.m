function [x,ierr,errore,iter,raggio]=mygserr(a,r,c,b,x0,Kmax,tol)
% purpose: solve the system of equations Ax=b using the iterative method of Gauss-Seidel
%
% syntax: [x, ierr, err, k] = mygserr(a, r, c, b, x0, Kmax, tol)
% input:
% a: vector containing the nonzero elements of matrix A
% r: vector containing the row indices of the nonzero elements of matrix A
% c: vector containing the column indices of the nonzero elements of matrix A
%
% NOTE: the elements of vectors a, r, and c must be ordered such that A(r(k), c(k)) = a(k)
%
% b: vector of right-hand side terms
% x0: initial approximation of the solution to the system
% Kmax: safety factor, maximum number of iterations
% tol: maximum tolerated error on the solution, see ierr
% output:
% x: approximation of the solution to the system Ax=b
% ierr: error indicator: if the algorithm finds a solution with error less than the tolerance in fewer than kmax iterations, ierr=0; otherwise, if the tolerance is not satisfied or the maximum number of iterations is exceeded, ierr=-1
% errore: vector containing the error estimates iterated over each iteration
% iter: vector containing the completed iterations
%
% stopping criterion: error estimate using the infinity norm. It is proven that an error estimate is
% norm(y-x, Inf) / norm(y, Inf);
%
% example:
% r = [1 1 2 2 3 3 4 4 5 5 5 6 6 6];
% c = [1 5 1 2 3 5 1 4 1 3 5 1 2 6];
% a = [-9 1 2 -8 -7 1 3 4 -1 -1 6 2 3 10];
%
% b = [-9; 2; 0; 3; -1; 2 ];
%
% b = sparse(b);
%
% x0 = zeros(6, 1);
% x0 = sparse(x0);
% tol = 10^-6;
% kmax = 100;
%
% [x, ierr, err, k] = mygserr(a, r, c, b, x0, kmax, tol)
% NOTE: Iterative methods, like the one in question, are particularly advantageous for sparse matrices. To save memory, we can allocate matrices and vectors in sparse format. In this way, the result will also be given in sparse format, and MATLAB operations recognize the formats.
%
% author: Zippo Luigi Emanuele

n=length(x0);
nz=length(r);
k=0;
err=tol+1;
ierr=0;
errore=[];
iter=[];

A=sparse(r,c,a,n,n,nz);

D=diag(diag(A));

I=sparse(eye(n));

L=-tril(A,-1);

% U=-triu(A,1);

x=x0;

% diff=inv(D-L);
% Tgs=I-diff*A;
% c=diff*b;

Tgs=I-(D-L)\A;
c=(D-L)\b;
raggio=max(abs(eigs(Tgs)));

while err>tol && k<Kmax

y=Tgs*x+c;
err=norm(y-x,Inf)/norm(y,Inf);
errore(k+1)=err;
iter(k+1)=k;
x=y;
k=k+1;

end

if k>Kmax || err>tol

    ierr=-1;

end



end
