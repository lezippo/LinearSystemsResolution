function [A,info]=mylu(A)
% Purpose: LU factorization of matrix A: determine the matrix L, lower triangular,
% where the multiplicative factors of the Gaussian elimination algorithm are allocated iteratively,
% and the matrix U, upper triangular, matrix in which A is transformed after the Gaussian elimination algorithm.
%
% Syntax: [A,info]=mylu(A)
% Input:
% A:       matrix to be factorized. NOTE: the matrix must NOT have
%          null pivots, otherwise the algorithm will terminate
% Output:
% A:       factorized matrix. To save memory, matrices L and U
%          are allocated directly in the input matrix A. BE CAREFUL:
%          the matrix L has all 1s on the main diagonal by
%          construction: since they are already known, they are not allocated;
%          consequently, in the factorized matrix A, the main diagonal
%          is occupied by the elements of U
% info:    error indicator: ierr=-1 if the matrix has a null pivot;
%          ierr=0 in other cases
%
% Example:
% A=[ 1 2 3
%     1 1 2
%     5 4 3 ];
%
% [A,info]=mylu(A);
%
% Author: Luigi Emanuele Zippo

n=size(A,1);
info=0;

for k=1:(n-1)
    
    if A(k,k)==0

        % Check if A(k,k) is different from 0 to avoid division by zero

        info=-1;
        break

    end

    for i=(k+1):n

        A(i,k)=A(i,k)/A(k,k);

        for j=(k+1):n

            A(i,j)=A(i,j)-A(i,k)*A(k,j);

        end

    end

end

if info==-1 || A(n,n)==0
    
    % If we did not check outside the loop that all pivots are non-null,
    % we would have no information about the last pivot: A(n,n)
    
    info=-1;
    disp('ERROR: a pivot is null')

end

end
