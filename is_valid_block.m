function [Block,pass] = is_valid_block(Block,min_correct_ans,max_lim,min_lim)
    Block.passed = filter_limit_time(Block.rt,max_lim,min_lim,Block.passed);
    Block.passed = filter_num_of_wrong_ans(Block.acc,Block.passed);
    valid_ans = find(Block.passed == 1);
    pass = true;
    if length(valid_ans) < min_correct_ans
        pass = false;
    end
end

    