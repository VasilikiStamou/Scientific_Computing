function T=blkToeplitzTrid(n,B,A,C)
%Author: V. Stamou, AM 1059543, Date: 7/1/2022

%Verify the inputs are 2-d arrays.
  if (length(size(A))~=2) || ...
     (length(size(B))~=2) || ...
     (length(size(C))~=2) 
    error 'Inputs must be 2d arrays if a replication factor is provided'
  end
  
%Get block sizes & check for consistency
  [m,q] = size(A);
  if m~=q
    error 'Blocks must be square arrays'
  end
  if isempty(A)
    error 'Blocks must be non-empty arrays or scalars'
  end
  if any(size(A)~=size(B)) || any(size(A)~=size(C))
    error 'A, B, C are not identical in size'
  end
  if isempty(n) || (length(n)>1) || (n<1) || (n~=floor(n))
    error 'n must be a positive scalar integer'
  end
  
%Scalar inputs
  if m==1
    if n==1
      T = A;
    else
      T = spdiags(repmat([B A C],n,1),-1:1,n,n);
    end
    return
  end  
  
  %Main diagonal elements of each array 
  v = repmat(A(:),n,1);
  if n>1
    %sub-diagonal
    v=[v;repmat(B(:),n-1,1)];
    %super-diagonal
    v=[v;repmat(C(:),n-1,1)];
  end
  
  
%Generate the index arrays 
 %main diagonal
[ind1,ind2,ind3]=ndgrid(0:m-1,0:q-1,0:n-1);
rind = 1+ind1(:)+m*ind3(:);
cind = 1+ind2(:)+q*ind3(:);
% then the sub and super diagonal blocks.
if n>1
  %sub-diagonal
  [ind1,ind2,ind3]=ndgrid(0:m-1,0:q-1,0:n-2);
  rind = [rind;1+m+ind1(:)+m*ind3(:)];
  cind = [cind;1+ind2(:)+q*ind3(:)];
  %super-diagonal
  rind = [rind;1+ind1(:)+m*ind3(:)];
  cind = [cind;1+q+ind2(:)+q*ind3(:)];
end
%final array 
T = sparse(rind,cind,v,n*m,n*q);

  
  
  