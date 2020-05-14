function [slope , line] = linfit(x,y)
%x - x axes data
%y - y axes data

fit = polyfit(x,y,1);
slope = fit(1);
line = polyval(fit, min(x):max(x));
end