%Author: V. Stamou, AM 1059543, Date: 15/1/2022
clear;clc;
n=64; m=32; nb=m;
y=eye(n*m,1); x=ones(n*m,1);
yy=y;
T=toeplitz([4,-1,zeros(1,m-2)]);
S=blkToeplitzTrid(n,inv(T),T^2,T);

yy=yy+S*x;

[val,brow_idx,bcol_ptr]=sp_mx2bccs(S,nb);

y=spmv_bccs(y,x,nb,val,brow_idx,bcol_ptr);

d=norm(y-yy);