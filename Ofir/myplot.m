function   myplot(cond , F_m , F_std ,C_m , C_std , set_sz, F_line, C_line,F_slope , C_slope , F_rho , C_rho , F_sig, C_sig )
% cond - off/on string
%F_m , C_m - RT means per condition
%F_std , C_std - RT standard deviation per condition
% set_sz - set sizes of the experiment
% F_line , C_line - line fit per condition
%F_slope, C_slope - slope of the fitted line
%F_rho , C_rho - pearson's r
%F_sig , C_sig - significant of pearson's r


c = errorbar( set_sz , F_m  , F_std , 'linewidth', 2 );
c.Bar.LineStyle = 'dotted';
xlabel('Set size')
ylabel('Response time [sec]')
hold on
d = errorbar( set_sz, C_m , C_std , 'linewidth', 2 );
d.Bar.LineStyle = 'dotted';
plot(min(set_sz):max(set_sz) , F_line , 'm' ,'LineWidth' , 1.35 ,'LineStyle' , '-.')
plot(min(set_sz):max(set_sz) , C_line , 'g', 'LineWidth' , 1.35 ,'LineStyle' , '-.')
legend('Single feature condition' , 'Conjunction condition' , 'Feature fit' , 'Conjunction fit')
xlabel('Set size' , 'fontsize' , 16)
ylabel('Response time [sec]' , 'fontsize' , 16)
title(['Target ' cond ' response time'] , 'fontsize' , 18)

str1 = ['Conjunction Pearson''s \rho = ', num2str(C_rho), C_sig];
str2 =  ['Feature Pearson''s \rho = ', num2str(F_rho), F_sig];
str3 = ['Conjunction fit slope = ' , num2str(C_slope)];
str4 = ['Feature fit slope = ' , num2str(F_slope)];
str1 = strjoin(str1);
str2 = strjoin(str2);

axe = gca;
text(1.05*axe.XLim(1), 0.95*axe.YLim(2),[str1 ,  str2 ,' ' ,str3 ,str4], ...
    'fontsize', 12, 'verticalalignment', 'top', 'horizontalalignment', 'left');
axe.FontSize = 12;

end