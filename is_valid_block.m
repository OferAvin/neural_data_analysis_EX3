%this function uses filters function and checks if there is enough valid 
%responses, if not enough return false, it also returns the num of valid trails.s 
function [Block,pass,num_of_valid_ans] = is_valid_block(Block,min_correct_ans,max_lim,min_lim)
    Block.passed = filter_limit_time(Block.rt,max_lim,min_lim,Block.passed);
    Block.passed = filter_num_of_wrong_ans(Block.acc,Block.passed);
    valid_ans = find(Block.passed == 1);
    pass = true;
    num_of_valid_ans = length(valid_ans);
    if num_of_valid_ans < min_correct_ans
        pass = false;
    end
end

    