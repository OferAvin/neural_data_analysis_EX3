function [pass] = is_valid_block(is_pass,min_correct_ans)
    valid_ans = find(is_pass == 'true');
    pass = true;
    if length(valid_ans) < min_correct_ans
        pass = false;
    end
end

    