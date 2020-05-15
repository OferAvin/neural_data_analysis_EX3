function S = build_struct(size,cond,has_target,set_sizes,trial_num)
    num_of_sizes = length(set_sizes);
    trailZzer = zeros(trial_num,1);
    bool = true(trial_num,1);
    
    generic_res_table1 = build_double_table(["mean","SD"],has_target);
    generic_res_table2 = build_cell_table(cond,has_target,num_of_sizes);
    
    GenericBlock = struct('condition', "", 'set_size', 0,...
        'has_target', bool, 'acc', bool,'rt', trailZzer, 'passed',bool,'block_results',generic_res_table1);

    cur_cond = 0;
    for i = 1:size
        if mod(i - 1,num_of_sizes) == 0
            cur_cond = cur_cond + 1;
        end
        cur_block = char("B" + i);
        S.(cur_block) = GenericBlock; 
        S.(cur_block).condition = cond(cur_cond);
        S.(cur_block).set_size = set_sizes(mod(i-1,num_of_sizes)+1);
    end

    S.All_results = struct('mean', generic_res_table2 ,'sd',generic_res_table2,...
        'p_val',generic_res_table1,'rho',generic_res_table1,'fit',generic_res_table2);
end