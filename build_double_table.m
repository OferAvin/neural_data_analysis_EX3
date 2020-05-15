%this function creates a table with the specified row and colums names
function [data_as_table] = build_double_table(row_names,col_names)
    data_as_table = zeros(length(row_names),length(col_names));
    data_as_table = array2table(data_as_table,'VariableNames',col_names,'RowNames',row_names);