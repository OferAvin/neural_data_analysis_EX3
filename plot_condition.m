function plot_condition(Data,set_sizes,condition,scenario,data_color,errorbar_color,fit_color)
    errorbar(set_sizes,Data.mean.has_target{condition},...
        Data.sd.(scenario){condition},'Color',errorbar_color,'LineWidth',0.5);
    plot(set_sizes,Data.mean.(scenario){condition},'Color',data_color);
    plot(set_sizes,Data.fit.(scenario){condition},'Color',fit_color,'LineStyle','-.')
end