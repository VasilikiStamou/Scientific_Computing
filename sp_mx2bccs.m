function [val,brow_idx,bcol_ptr]=sp_mx2bccs(A,nb)
%Author: V. Stamou, AM 1059543, Date: 8/1/2022
dim = ones(1,size(A,1)/nb)*nb;
C = mat2cell(A, dim, dim);
non_zeros=cellfun(@(x) nnz(x)~=0, C); % non-zero blocks
D=C(non_zeros);
v=[];

%Find val
for i=1:size(D,1)
       Dblock = cell2mat(D(i));
            Dblock = Dblock(:)';
            v = [v Dblock];
end
val=full(v);
    
%Find brow_idx & brow_ptr
[ri,co,values]=cellfun(@(x)find(x),C,'UniformOutput',false);
[brow_idx,J] = find(~cellfun(@isempty,ri));
bcol_ptr = accumarray(J+1,1);
bcol_ptr = cumsum(bcol_ptr)+1;
