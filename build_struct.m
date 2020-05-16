%this function creates the structure where all data is saved
%in this structure there is a structure for every block including
%parameters, data and results. there is another structure all results from
%all blocks
function S = build_struct(size,cond,scenario,set_sizes,trial_num)
    mean_sd = ["mean","SD"];
    num_of_sizes = length(set_sizes);
    trailZzer = zeros(trial_num,1);
    bool = true(trial_num,1);
    
    generic_res_table1 = build_double_table(mean_sd,scenario); 
    generic_res_table2 = build_cell_table(cond,scenario,num_of_sizes);
    generic_res_table3 = build_double_table(cond,scenario,num_of_sizes);
    
    GenericBlock = struct('condition', "", 'set_size', 0,...
        'has_target', bool, 'acc', bool,'rt', trailZzer, 'passed',bool,'block_results',generic_res_table1);

    %creating structure for eache block
    cur_cond = 0;
    for i = 1:size
        if mod(i - 1,num_of_sizes) == 0     %every num_of_size blocks switch cond  
            cur_cond = cur_cond + 1;
        end
        cur_block = char("B" + i);
        S.(cur_block) = GenericBlock; 
        S.(cur_block).condition = cond(cur_cond);
        S.(cur_block).set_size = set_sizes(mod(i-1,num_of_sizes)+1);
    end
    
    %creating all results structure
    S.All_results = struct('mean', generic_res_table2 ,'sd',generic_res_table2,...
        'p_val',generic_res_table3,'rho',generic_res_table3,'fit',generic_res_table2);
end