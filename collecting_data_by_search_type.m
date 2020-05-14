function[mean_target,mean_no_target,SD_target,SD_no_target] = collecting_data_by_search_type(Expirament,exp_length,search_type)
    mean_target = zeros(length(exp_length),1);
    mean_no_target = zeros(length(exp_length),1);
    SD_target = zeros(length(exp_length),1);
    SD_no_target = zeros(length(exp_length),1);
    for i = 1:exp_length
        cur_block_name = (char("B"+i));
        Cur_block = Expirament.(cur_block_name);
        if Cur_block.condition == search_type
          mean_target(i) = table2array(Cur_block.results('mean','has_target'));
          mean_no_target(i) = table2array(Cur_block.results('mean','no_target'));
          SD_target(i) = table2array(Cur_block.results('SD','has_target'));
          SD_no_target(i) = table2array(Cur_block.results('SD','no_target'));
        end
    end
end
    
            
       
        