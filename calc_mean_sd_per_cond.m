function Block = calc_mean_sd_per_cond(Block,cond_vec)
    Block.results('mean','has_target') = {mean(Block.rt(cond_vec))};
    Block.results('SD','has_target') = {std(Block.rt(cond_vec))};
end