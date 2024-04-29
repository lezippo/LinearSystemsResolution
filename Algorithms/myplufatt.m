function [A,p,info]=myplufatt(A)
% Purpose: PLU factorization of matrix A with partial pivoting.
% Determine:
% - U upper triangular matrix, result of the Gaussian elimination algorithm applied to A;
% - L lower triangular matrix containing column by column the multiplicative factors
% of the Gaussian elimination algorithm;
% - P permutation matrix responsible for pivoting: at the k-th iteration,
% we search, in the k-th column, among the elements below A(k,k) the
% maximum in absolute value; if this does not coincide with A(k,k), the rows of the
% 2 elements are exchanged using a permutation matrix. The product
% of all permutation matrices involved in the algorithm coincides
% with P. The matrix P, being nothing but the identity matrix with rows
% permuted, is indicated with a vector p whose entries represent
% the swaps that need to be made on the rows of the identity matrix to
% obtain it.
%
% Syntax: [A,p,info]=myplufatt(A)
% Input:
% A:       matrix to be factorized
% Output:
% A:       factorized matrix: the matrix U is allocated in the upper half
% while matrix L is allocated in the lower half. The matrix L
% has all 1s on the main diagonal but they are not stored in A:
% the main diagonal of A is occupied by the entries of U
% p:       permutation vector: indicates the order in which the rows
% of the identity matrix should be considered to obtain P. For example:
% if p=[1 2 4 3]', to obtain P the third and fourth row must be swapped, i.e.:
% P=[ 1 0 0 0
%     0 1 0 0
%     0 0 0 1
%     0 0 1 0 ]
% info:    indicates if the last pivot is null, in particular if info=-1
%          the last pivot is null, if info=0 the pivot is non-null
%
% Example:
% A=[ 0  0  2  1  2
%     0  1  0  2 -1
%     1  2  0 -2  0
%     0  0  0 -1  1
%     0  1 -1  1 -1 ];
%
% [A,p,info]=myplufatt(A)
%
% Author: Luigi Emanuele Zippo

n=size(A,1);
p=1:n;
p=p';
info=0;

for k=1:n

        max=abs(A(k,k));
        r=k;

    for h=k:(n-1)

        % Search for the maximum absolute value among the elements below A(k,k)
        % in the k-th column

        if max<abs(A(h+1,k))

            max=abs(A(h+1,k));
            r=h+1;
           
        end

    end

        if A(r,k)==0 && k~=n
              
        k=k+1;
         
        else if A(r,k)==0 && k==n

        disp('The matrix is singular')
        info=-1;

        end
        
        end

        if A(r,k)~=0

            if r~=k

                % If the maximum is not A(k,k) swap the rows

                A([k r],:)=A([r k],:);
                p([k r],:)=p([r k],:);

            end

         for i=k+1:n

             A(i,k)=A(i,k)/A(k,k);

             for j=k+1:n

                  A(i,j)=A(i,j)-A(i,k)*A(k,j);

             end

         end

        end

end

end
