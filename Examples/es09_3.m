format long
n=1;
tol=0.5*10^-6;
err=tol-1;

while err<tol

n=n+1;
x=sishilb(n);

% The vector b of the constant terms is constructed so that the only
% solution of the system is x0 = [1, 1, ..., 1]. Therefore, we can
% calculate the error on x as |x - x0|.

x0=ones(n,1);
err=abs(x-x0);

end

disp('The largest integer such that x has 6 significant figures is:')
disp(n)
