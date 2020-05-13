function is_pass = filter_num_of_wrong_ans(acc,is_pass)
    wrong_ans = find(acc==0);
    is_pass(wrong_ans) = false;