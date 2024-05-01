A=[  5   7
    0.7  1 ];

b=[ 12
    1.7 ];

b2=[  12
     1.69 ];

c=cond(A);
A0=A;

[A,p,info]=myplufatt(A)

y=myfwsistemi(A,b(p));
x=mybw(A,y);

disp('Exact solution:')
disp(x)

y2=myfwsistemi(A,b2(p));
x2=mybw(A,y2);

disp('Perturbed solution:')
disp(x2)

r=b-A0*x2;
disp('Residual:')
disp(r)

disp('Error on the data:')
disp(norm(b-b2,"inf")/norm(b,"inf"))

disp('Condition number:')
disp(c)

disp('Error on the solution:')
disp(norm(x-x2,"inf")/norm(x,"inf"))

% As we can observe, the condition number of the matrix is large, data perturbation generates significant errors in the solution
