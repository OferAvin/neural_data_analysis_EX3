function [fit_vec] = linear_fit(set_size,mean,num_of_deg)
    line = polyfit(set_size,mean,num_of_deg);
    fit_vec = polyval(line(1),set_size);