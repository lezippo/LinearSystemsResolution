A=[ -10 2  5 -2
     1  5 -1  2
     2  3 -7  1
     1  0  3 -8 ];

% A is a strictly diagonally dominant matrix

[A,p,info]=myplufatt(A)

% The permutation vector p remains unchanged: in fact, for strictly diagonally dominant matrices, the LU factorization exists and is unique, and pivoting is not necessary.
