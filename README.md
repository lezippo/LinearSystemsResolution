# LinearSystemsResolution
Linear systems' resolution using Forward and Backward Substitution Algorithms, LU factorisation with and without partial pivoting, Gauss-Seidel and Jacobi Methods 

1. [Theory](#theory)
- [LU Factorization](#lu-factorization)
   - [With Partial Pivoting](#with-partial-pivoting)
   - [Without Partial Pivoting](#without-partial-pivoting)
- [Forward and Backward Substitution](#forward-and-backward-substitution)
- [Gauss-Seidel Method](#gauss-seidel-method)
- [Jacobi Method](#jacobi-method)
- [Computational Advantages: Gauss-Seidel and Jacobi Methods vs. LU Decomposition](#computational-advantages-gauss-seidel-and-jacobi-methods-vs-lu-decomposition)
2. [Function Documentation](#function-documentation)
- [mybw](#mybw)
- [myfw](#myfw)
- [myfwsistemi](#myfwsistemi)
- [mylu](#mylu)
- [myplufatt](#myplufatt)
- [mygs](#mygs)
- [myj](#myj)
- [mygserr](#mygserr)
- [myjerr](#myjerr)

# Theory

## LU Factorization

LU factorisation decomposes a square matrix $A$ into the product of a lower triangular matrix $L$ and an upper triangular matrix $U$: $A = LU$. This factorisation simplifies solving linear systems by reducing them to two triangular systems.

### With Partial Pivoting

Partial pivoting involves rearranging rows of $A$ during the factorisation process to ensure numerical stability. It swaps rows to ensure that the pivot element (the diagonal element being processed) is the largest in its column. This helps reduce errors introduced by floating-point arithmetic and improves the stability of the solution.

### Without Partial Pivoting

Without partial pivoting, LU factorisation may still be performed, but it can be less stable, especially for ill-conditioned matrices. The absence of row swapping can lead to numerical errors and inaccuracies in the solution, particularly when dealing with large or poorly conditioned systems.

## Forward and Backward Substitution

Once $A = LU$ is obtained, forward and backward substitution algorithms are used to solve the resulting triangular systems.

- **Forward Substitution**: Solves $Ly = b$ for $y$, where $L$ is the lower triangular matrix obtained from LU decomposition and $b$ is the right-hand side vector of the original linear system.
- **Backward Substitution**: Solves $Ux = y$ for $x$, where $U$ is the upper triangular matrix obtained from LU decomposition and $y$ is the solution obtained from forward substitution.

These substitution algorithms efficiently solve triangular systems without the need for costly matrix inversions, making them suitable for solving large linear systems.

## Gauss-Seidel Method

The Gauss-Seidel method iteratively improves an initial guess to the solution of a linear system by updating each component of the solution vector using the most recent information available. Here's the iterative process:

1. Decompose the coefficient matrix $A$ into $D$, $L$, and $U$.
2. Initialize the solution vector $x$ with an initial approximation $x^0$.
3. Iterate until convergence or maximum iterations:
    a. Calculate the next iteration using the formula $x^{k+1} = (D-L)^{-1} (U x^k + b)$.
    b. Check for convergence using the error estimate $\frac{||x-y||{\infty}}{||y||_{\infty}}$
4. Repeat steps 3 until convergence or maximum iterations are reached.

The Gauss-Seidel method typically converges faster than the Jacobi method because it uses updated values of the solution vector as soon as they become available.

## Jacobi Method

The Jacobi method is a simpler variant of the Gauss-Seidel method, where each component of the solution vector is updated simultaneously based on the previous iteration's values. Here's the iterative process:

1. Start with an initial guess $x^{(0)}$ for the solution vector $x$.
2. Decompose the coefficient matrix $A$ into $D$, $L$, and $U$.
3. Initialize the solution vector $x$ with an initial approximation $x^0$.
4. Iterate until convergence or maximum iterations:
   a. Calculate the next iteration using the formula $x^{k+1} = D^{-1}((L+U) x^k + b)$
   b. Check for convergence using the error estimate $\frac{||x-y||{\infty}}{||y||_{\infty}}$
Repeat the iteration until the solution converges within a specified tolerance or a maximum number of iterations is reached.

The Jacobi method is simpler to implement and parallelize compared to the Gauss-Seidel method, but it typically converges slower, especially for systems with strong coupling between variables.

# Computational Advantages: Gauss-Seidel and Jacobi Methods vs. LU Decomposition

When dealing with sparse matrices, where most of the elements are zero, Gauss-Seidel and Jacobi methods offer significant computational advantages over LU decomposition:

## Memory Efficiency

- **Gauss-Seidel and Jacobi**: These methods only require storing the non-zero elements and have low memory overhead. They are well-suited for sparse matrices, where storing all elements would be inefficient.
- **LU Decomposition**: Requires storing the entire matrix, leading to higher memory requirements, especially for large sparse matrices.

## Computational Efficiency

- **Gauss-Seidel and Jacobi**: Iterative methods that update only a subset of the solution vector at each iteration. They exploit the sparsity of the matrix, leading to fewer arithmetic operations per iteration.
- **LU Decomposition**: Involves decomposing the entire matrix into lower and upper triangular matrices, which can be computationally expensive, especially for large sparse matrices with many zero elements.

## Parallelization

- **Gauss-Seidel and Jacobi**: Easily parallelizable, as each component of the solution vector can be updated independently. Suitable for distributed computing environments and multi-core processors.
- **LU Decomposition**: Parallelization is more challenging due to the sequential nature of the decomposition process and dependencies between elements of the resulting matrices.

## Conclusion

For solving linear systems represented by sparse matrices, Gauss-Seidel and Jacobi methods offer superior memory and computational efficiency compared to LU decomposition. These iterative methods exploit the sparsity of the matrix, making them ideal choices for large-scale numerical simulations and computations.

# Code structure

# Function Documentation

## mybw

### Purpose
Solve systems with upper triangular associated matrix through the backward substitution algorithm.

### Input
- `U`: Matrix associated with the system. NOTE: `U` must be an upper triangular matrix.
- `b`: Column vector of constant terms.

### Output
- `x`: Solution of the system `Ux=b`.

## myfw

### Purpose
Solve systems with lower triangular associated matrix through the forward substitution algorithm.

### Input
- `L`: Matrix associated with the system. NOTE: `L` must be a lower triangular matrix.
- `b`: Column vector of constant terms.

### Output
- `x`: Solution of the system `Lx=b`.

## myfwsistemi

### Purpose
Solve systems with lower triangular associated matrix and unit diagonal through the forward substitution algorithm. The algorithm is designed for solving systems using LU factorization.

### Input
- `L`: Matrix associated with the system. NOTE: `L` must be a lower triangular matrix with unit diagonal.
- `b`: Column vector of known terms.

### Output
- `x`: Solution of the system `Lx=b`.

## mylu

### Purpose
LU factorization of matrix `A`: determine the matrix `L`, lower triangular, where the multiplicative factors of the Gaussian elimination algorithm are allocated iteratively, and the matrix `U`, upper triangular, matrix in which `A` is transformed after the Gaussian elimination algorithm.

### Input
- `A`: Matrix to be factorized. NOTE: the matrix must NOT have null pivots, otherwise the algorithm will terminate.

### Output
- `A`: Factorized matrix. To save memory, matrices `L` and `U` are allocated directly in the input matrix `A`.
- `info`: Error indicator.

## myplufatt

### Purpose
PLU factorization of matrix `A` with partial pivoting. Determine: `U` upper triangular matrix, result of the Gaussian elimination algorithm applied to `A`; `L` lower triangular matrix containing column by column the multiplicative factors of the Gaussian elimination algorithm; `P` permutation matrix responsible for pivoting.

### Input
- `A`: Matrix to be factorized.

### Output
- `A`: Factorized matrix.
- `p`: Permutation vector: indicates the order in which the rows of the identity matrix should be considered to obtain `P`.
- `info`: Indicates if the last pivot is null.

## mygs

### Purpose
Solve the system of equations Ax=b using the Gauss-Seidel iterative method.

### Input
- `a`: Vector containing the non-zero elements of matrix A.
- `r`: Vector containing the row indices of the non-zero elements of matrix A.
- `c`: Vector containing the column indices of the non-zero elements of matrix A.
- `b`: Column vector of constant terms.
- `x0`: Initial approximation of the solution to the system Ax=b.
- `Kmax`: Maximum number of iterations.
- `tol`: Maximum tolerated error on the solution.

### Output
- `x`: Approximation of the solution to the system Ax=b.
- `ierr`: Error indicator. If the algorithm finds a solution with an error less than the tolerance in fewer than `Kmax` iterations, `ierr=0`; otherwise, if the tolerance is not met or if the `Kmax` iterations are exceeded, `ierr=-1`.

## myj

### Purpose
Solve the system of equations Ax=b using the Jacobi iterative method.

### Input
- `a`: Vector containing the non-zero elements of matrix A.
- `r`: Vector containing the row indices of the non-zero elements of matrix A.
- `c`: Vector containing the column indices of the non-zero elements of matrix A.
- `b`: Column vector of constant terms.
- `x0`: Initial approximation of the solution to the system Ax=b.
- `Kmax`: Maximum number of iterations.
- `tol`: Maximum tolerated error on the solution.

### Output
- `x`: Approximation of the solution to the system Ax=b.
- `ierr`: Error indicator. If the algorithm finds a solution with an error less than the tolerance in fewer than `Kmax` iterations, `ierr=0`; otherwise, if the tolerance is not met or if the `Kmax` iterations are exceeded, `ierr=-1`.

## mygserr

### Purpose
Solve the system of equations Ax=b using the Gauss-Seidel iterative method with error estimation.

### Input
- `a`: Vector containing the non-zero elements of matrix A.
- `r`: Vector containing the row indices of the non-zero elements of matrix A.
- `c`: Vector containing the column indices of the non-zero elements of matrix A.
- `b`: Column vector of constant terms.
- `x0`: Initial approximation of the solution to the system Ax=b.
- `Kmax`: Maximum number of iterations.
- `tol`: Maximum tolerated error on the solution.

### Output
- `x`: Approximation of the solution to the system Ax=b.
- `ierr`: Error indicator. If the algorithm finds a solution with an error less than the tolerance in fewer than `Kmax` iterations, `ierr=0`; otherwise, if the tolerance is not met or if the `Kmax` iterations are exceeded, `ierr=-1`.
- `errore`: Vector containing the error estimates iterated over each iteration.
- `iter`: Vector containing the completed iterations.
- `raggio`: Maximum absolute eigenvalue of the iterative matrix.

## myjerr

### Purpose
Solve the system of equations Ax=b using the Jacobi iterative method with error estimation.

### Input
- `a`: Vector containing the non-zero elements of matrix A.
- `r`: Vector containing the row indices of the non-zero elements of matrix A.
- `c`: Vector containing the column indices of the non-zero elements of matrix A.
- `b`: Column vector of constant terms.
- `x0`: Initial approximation of the solution to the system Ax=b.
- `Kmax`: Maximum number of iterations.
- `tol`: Maximum tolerated error on the solution.

### Output
- `x`: Approximation of the solution to the system Ax=b.
- `ierr`: Error indicator. If the algorithm finds a solution with an error less than the tolerance in fewer than `Kmax` iterations, `ierr=0`; otherwise, if the tolerance is not met or if the `Kmax` iterations are exceeded, `ierr=-1`.
- `errore`: Vector containing the error estimates iterated over each iteration.
- `iter`: Vector containing the completed iterations.
- `raggio`: Maximum absolute eigenvalue of the iterative matrix.
