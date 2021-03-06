function plot_condition(Data,set_sizes,condition,scenario,title,ax_lable,data_color,fit_color,y_limit)
    errorbar(set_sizes,Data.mean.(scenario){condition},...
        Data.sd.(scenario){condition},'LineWidth',0.5);
    plot(set_sizes,Data.fit.(scenario){condition},'Color',fit_color,'LineStyle','-.')
    sgtitle(title,'FontSize',20);  
    xlabel(ax_lable(1),'FontSize',12); ylabel(ax_lable(2),'FontSize',12);
    ylim(y_limit);
end