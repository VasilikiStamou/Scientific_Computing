function [val,row_ip,col_ip]=sp_mat2latex(A,sp_type)
%Author: V. Stamou, AM 1059543, Date: 12/1/2022
alignment = 'l';
fid = fopen(sp_type, 'w');


if sp_type=='csc'
    %%CRC
    [row_ip,J,val] = find(A);
    col_ip = accumarray(J+1,1);
    col_ip = cumsum(col_ip)+1;

    length_row_ip=size(row_ip,1);length_col_ip=size(col_ip,1);length_val=size(val,1);


elseif sp_type=='csr'
    %%CRS
    [col_ip,J,val] = find(A');
    row_ip = accumarray(J+1,1);
    row_ip = cumsum(row_ip)+1;

    length_row_ip=size(row_ip,1);length_col_ip=size(col_ip,1);length_val=size(val,1);

end


%%%    
col_ip = num2cell(col_ip);row_ip = num2cell(row_ip);val = num2cell(val);

for lr=1:length_row_ip
    row_ip{lr} = num2str(row_ip{lr});
end
for lr=1:length_col_ip
    col_ip{lr} = num2str(col_ip{lr});
end
for lr=1:length_val
    val{lr} = num2str(val{lr});
end
%%%

%val
fprintf(fid,'\\\\\r\nval=');
        fprintf(fid, '\\begin{tabular}{|');
        for i=1:length_val
            fprintf(fid, '%c|', alignment);
        end      
        fprintf(fid, '}\r\n');    
        fprintf(fid, '\\hline\r\n');

        for lv=1:length_val-1
            fprintf(fid, '%s&', val{lv});
        end
        fprintf(fid, '%s\\\\\\hline\r\n', val{length_val});
        fprintf(fid, '\\end{tabular}\r\n');

if sp_type=='csc'
%ri
fprintf(fid,'\\\\\r\nIA=');
        fprintf(fid, '\\begin{tabular}{|');

        for i=1:length_row_ip
            fprintf(fid, '%c|', alignment);
        end      
        fprintf(fid, '}\r\n');    
        fprintf(fid, '\\hline\r\n');

        for lr=1:length_row_ip-1
            fprintf(fid, '%s&', row_ip{lr});
        end
        fprintf(fid, '%s\\\\\\hline\r\n', row_ip{length_row_ip});
        fprintf(fid, '\\end{tabular}\r\n');
%cp
fprintf(fid,'\\\\\r\nJA=');
        fprintf(fid, '\\begin{tabular}{|');

        for i=1:length_col_ip
            fprintf(fid, '%c|', alignment);
        end      
        fprintf(fid, '}\r\n');    
        fprintf(fid, '\\hline\r\n');

        for lc=1:length_col_ip-1
            fprintf(fid, '%s&', col_ip{lc});
        end
        fprintf(fid, '%s\\\\\\hline\r\n', col_ip{length_col_ip});
        fprintf(fid, '\\end{tabular}\r\n');

elseif sp_type=='csr'
%ci
fprintf(fid,'\\\\\r\nIA=');
        fprintf(fid, '\\begin{tabular}{|');

        for i=1:length_col_ip
            fprintf(fid, '%c|', alignment);
        end      
        fprintf(fid, '}\r\n');    
        fprintf(fid, '\\hline\r\n');

        for lc=1:length_col_ip-1
            fprintf(fid, '%s&', col_ip{lc});
        end
        fprintf(fid, '%s\\\\\\hline\r\n', col_ip{length_col_ip});
        fprintf(fid, '\\end{tabular}\r\n');

%rp
fprintf(fid,'\\\\\r\nJA=');
        fprintf(fid, '\\begin{tabular}{|');

        for i=1:length_row_ip
            fprintf(fid, '%c|', alignment);
        end      
        fprintf(fid, '}\r\n');    
        fprintf(fid, '\\hline\r\n');

        for lr=1:length_row_ip-1
            fprintf(fid, '%s&', row_ip{lr});
        end
        fprintf(fid, '%s\\\\\\hline\r\n', row_ip{length_row_ip});
        fprintf(fid, '\\end{tabular}\r\n');

end

    fclose(fid);