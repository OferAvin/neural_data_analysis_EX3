function S = build_struct(size,cond,set_sizes,trial_num)
    num_of_sizes = length(set_sizes);
    zer = zeros(trial_num,1);
    bool = true(trial_num,1);
    results = zeros(2,2);
    results = array2table(results,'VariableNames',{'has_target','no_target'},...
        'RowNames',{'mean','SD'});
    GenericBlock = struct('condition', "", 'set_size', 0,...
        'has_target', bool, 'acc', bool,'rt', zer, 'passed',bool,'results',results);
    cur_cond = 0;
    for i = 1:size
        if mod(i - 1,num_of_sizes) == 0
            cur_cond = cur_cond + 1;
        end
        cur_block = char("B" + i);
        S.(cur_block) = GenericBlock; 
        S.(cur_block).condition = cond(cur_cond);
        S.(cur_block).set_size = set_sizes(mod(i,num_of_sizes)+1);
    end
end