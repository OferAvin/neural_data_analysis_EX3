%function that takes set size and mean and returns pearson corr, and
%polynom fit
function[rho,pval,y] = stats(set_size,mean)

[rho,pval] = corr(set_size',mean');
p = polyfit(set_size,mean,1);
y = polyval(p,set_size);

