function [data_as_table] = build_cell_table(row_names,col_names,arr_length)
    data_as_table = cell(length(row_names),length(col_names));
    data_as_table(:,:) = {zeros(1,arr_length)};
    data_as_table = array2table(data_as_table,'VariableNames',col_names,'RowNames',row_names);
end