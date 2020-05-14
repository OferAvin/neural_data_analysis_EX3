function[mean_target,mean_no_target,SD_target,SD_no_target] = collecting_data_by_search_type(Expirament,length_exp,search_type)
    mean_target = zeros(length(length_exp),1);
    mean_no_target = zeros(length(length_exp),1);
    SD_target = zeros(length(length_exp),1);
    SD_no_target = zeros(length(length_exp),1);
    for i = 1:length_exp
        cur_block_name = (char("B"+i));
        Cur_block = Expirament.(cur_block_name);
        if Cur_block.condition == search_type
          mean_target(i) = Cur_block.results('mean','has_target');
          mean_no_target(i) = Cur_block.results('mean','no_target');
          SD_target(i) = Cur_block.results('SD','has_target');
          SD_no_target(i) = Cur_block.results('SD','no_target');
        end
    end
    
            
       
        