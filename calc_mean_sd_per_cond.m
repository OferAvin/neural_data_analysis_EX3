function [Expirament,avg,sd] = calc_mean_sd_per_cond(Expirament,block_idx,to_calc_vec,has_target,cond,num_of_sizes)
    
    cur_block_name = (char("B"+block_idx));
    set_size = Expirament.(cur_block_name).set_size;
    cond_idx = find(contains(cond,Expirament.(cur_block_name).condition));
    
    avg = mean(Expirament.(cur_block_name).rt(to_calc_vec));
    sd = std(Expirament.(cur_block_name).rt(to_calc_vec));
    
    Expirament.(cur_block_name).block_results('mean',char(has_target)) = {avg};
    Expirament.(cur_block_name).block_results('SD',char(has_target)) = {sd};
    Expirament.All_results.mean.(has_target){cond_idx}(set_size/num_of_sizes) = avg;
    Expirament.All_results.sd.(has_target){cond_idx}(set_size/num_of_sizes) = sd;
end