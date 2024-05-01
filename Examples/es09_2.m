A=[ 3.50  2.77 -0.76   1.80
   -1.80  2.68  3.44  -0.09
    0.27  5.07  6.90   1.61 
    1.71  5.45  2.68   1.71 ];

b=[ 7.31 
    4.23 
    13.85
    11.55 ];

format long

A0=A;

[A,p,info]=myplufatt(A)

y=myfwsistemi(A,b(p));
x=mybw(A,y);

disp('Solution:')
disp(x)

c=cond(A0,inf);
disp('Condition number: ')
disp(c)

r=b-A0*x;
disp('Residual: ')
disp(r)

% The condition number of the matrix is large, indicating that the solution of the system may be imprecise. However, in this particular case:
% norm(x - X) / norm(X) <= K(A) * norm(r) / norm(b)
% i. e. the error on the solution is bounded by the product of the condition number and the norm of the residue
% Therefore, despite K(A) being large, the error is small because norm(r) / norm(b) is extremely small.

disp('The error is bounded by:')
disp(c * norm(r, 'inf') / norm(b, 'inf'))

