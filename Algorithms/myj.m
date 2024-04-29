function [x,ierr]=myj(a,r,c,b,x0,Kmax,tol)
% Purpose: Solve the system of equations Ax=b using the Jacobi iterative method
%
% Syntax: [x,ierr]=myj(a,r,c,b,x0,Kmax,tol)
% Input:
% a:       vector containing the non-zero elements of matrix A
% r:       vector containing the row indices of the non-zero elements of matrix A
% c:       vector containing the column indices of the non-zero elements of matrix A
%
% NOTE: the elements of vectors a, r, and c must be ordered such that A(r(k),c(k))=a(k)
% b:       vector of the constant terms
% x0:      initial approximation of the solution of the system
% Kmax:    safety factor, maximum number of iterations
% tol:     maximum tolerated error on the solution, see ierr
% Output:
% x:       approximation of the solution of the system Ax=b
% ierr:    error indicator: if the algorithm finds a solution with error less
%          than the tolerance within Kmax iterations, ierr=0; otherwise, if
%          the tolerance is not satisfied or the number of iterations exceeds
%          Kmax, ierr=-1
%
% Stopping criterion: error estimation using the infinity norm. It is
%                     shown that an error estimation is
%                     norm(y-x,Inf)/norm(y,Inf);
%
% Example:
% r=[  1  1  2  2  3  3  4  4  5  5  5  6  6  6  ];
% c=[  1  5  1  2  3  5  1  4  1  3  5  1  2  6  ];
% a=[ -9  1  2 -8 -7  1  3  4 -1 -1  6  2  3  10 ];
%
% b= [ -9; 2; 0; 3; -1; 2];
%
% b=sparse(b);
%
% x0=zeros(6,1);
% x0=sparse(x0);
% tol=10^-6;
% kmax=100;
%
% [x,ierr]=myj(a,r,c,b,x0,kmax,tol)
%
% NOTE: Iterative methods, like this one, are particularly advantageous for
% sparse matrices. To save memory, we can allocate matrices and vectors in
% sparse format. In this way, the result will also be given in sparse format
% (Matlab operations recognize the formats).
%
% Author: Luigi Emanuele Zippo

n=length(x0);
nz=length(r);
k=0;

% Force entry into the while loop by setting err>tol
err=tol+1;
ierr=0;

A=sparse(r,c,a,n,n,nz);

D=diag(diag(A));
L=-tril(A,-1);
U=-triu(A,1);
x=x0;

while err>tol && k<Kmax
    y=D\((L+U)*x+b);
    err=norm(y-x,Inf)/norm(y,Inf);
    x=y;
    k=k+1;
end

if k>Kmax || err>tol
    ierr=-1;
end

end
