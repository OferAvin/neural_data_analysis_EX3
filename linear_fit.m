%this function perform linear fit (degree of polinum is 1)
%it returns the calculated valuse after using the fitted function
function [fit_vec] = linear_fit(x,y)
    line = polyfit(x,y,1);
    fit_vec = polyval(line,x);
end