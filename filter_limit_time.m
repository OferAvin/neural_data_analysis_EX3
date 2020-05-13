function is_pass = filter_limit_time(rt,max_lim,min_lim,is_pass)
    to_long_answer = find(rt>max_lim);
    to_short_answer = find(rt<min_lim);
    is_pass(to_long_answer) = false;
    is_pass(to_short_answer) = false;
    
