%this function calculates mean and sd for each condition and target
%scenario, it assigns the calculated values to every block results and to
%all structure results
function [Expirament,avg,sd] = calc_mean_sd_per_cond(Expirament,idx,vec_to_calc,scenario,num_of_sizes)
    
    cur_block_name = (char("B"+idx));
    set_size = Expirament.(cur_block_name).set_size;
%     cond_idx = find(contains(cond,Expirament.(cur_block_name).condition));
    condition = Expirament.(cur_block_name).condition;
    
    avg = mean(Expirament.(cur_block_name).rt(vec_to_calc));
    sd = std(Expirament.(cur_block_name).rt(vec_to_calc));
    
    Expirament.(cur_block_name).block_results('mean',char(scenario)) = {avg};
    Expirament.(cur_block_name).block_results('SD',char(scenario)) = {sd};
    
    Expirament.All_results.mean.(scenario){condition}(set_size/num_of_sizes) = avg;
    Expirament.All_results.sd.(scenario){condition}(set_size/num_of_sizes) = sd;
end