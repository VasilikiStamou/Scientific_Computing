function y=spmv_bccs(y,x,nb,val,brow_idx,bcol_ptr)
%Author: V. Stamou, AM 1059543, Date: 11/1/2022
block=1;
k=0;
col_counter=1;

for reps=2:size(bcol_ptr,1)
    for t=1:bcol_ptr(reps)-bcol_ptr(reps-1)
        for i=1:nb
            y(nb*(brow_idx(block)-1)+i)=y(nb*(brow_idx(block)-1)+i) + val(k+i)*x(col_counter);
        end
    k=k+nb;
    for l=col_counter+1:col_counter+nb-1
        for j=1:nb
            y(nb*(brow_idx(block)-1)+j)=y(nb*(brow_idx(block)-1)+j) + val(k+j)*x(l);
        end
        k=k+nb;
    end
        block=block+1;
    end
    col_counter=col_counter+nb;
end

