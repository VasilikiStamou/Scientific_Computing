# Scientific_Computing
Sparse representations and Matrix constructions

sp_mat2latex: function which returns in LATEX code the sparse CSR or CSC representation of a matrix which is in sparse form in MATLAB.

blkToeplitzTrid: function which given square matrices A, B, C of size mxm, constructs the block Toeplitz tridiagonal matrix in sparse form.

sp_mx2bccs: function which given a square sparse matrix A and an integer nb (block size), returns a representation we call BCCS (block compressed column storage). BCCS is the block-by-column representation corresponding to (most extensively studied in the literature) BCRS (block compressed row storage).

spmv_bccs: function that takes as input an array in BCCS representation and returns the vector 
y <- y + Ax. It uses sparse representation and the vectors in the input and output are all in normal (dense) representation.

