function [data_as_table] = build_table(dim1,dim2,var_name1,var_name2,row_name1,row_name2)
    data_as_table = zeros(dim1,dim2);
    data_as_table = array2table(data_as_table,'VariableNames',{var_name1,var_name2},...
        'RowNames',{row_name1,row_name2});