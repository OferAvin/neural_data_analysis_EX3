function S = build_struct(size,cond,set_sizes,trial_num)
    num_of_sizes = length(set_sizes);
    sizesZer = zeros(1,num_of_sizes);
    trailZzer = zeros(trial_num,1);
    bool = true(trial_num,1);
    block_results = build_table(["has_target", "no_target"],["mean","SD"]);
    generic_res_table = build_table(cond,["has_target", "no_target"]);
    GenericBlock = struct('condition', "", 'set_size', 0,...
        'has_target', bool, 'acc', bool,'rt', trailZzer, 'passed',bool,'results',block_results);
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

    S.All_results = struct('meanTargetFeat',sizesZer,'SDTargetFeat',sizesZer,...
        'meanNoTargetFeat',sizesZer,'SDNoTargetFeat',sizesZer,'meanTargetConj',sizesZer,...
        'SDTargetConj',sizesZer,'meanNoTargetConj',sizesZer,'SDNoTargetConj',sizesZer,...
        'p_val',generic_res_table,'rho',generic_res_table,'fit',generic_res_table);
end