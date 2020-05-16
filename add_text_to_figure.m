function add_text_to_figure(Data,condition,scenario)
    conj_rho_text = [condition(1) + ' rho = ',num2str(Data.rho.(scenario)(condition(1)))];
    conj_p_val_text = [condition(1) + ' p_val = ',num2str(Data.p_val.(scenario)(condition(1)))];
    feat_rho_text = [condition(2) + ' rho = ',num2str(Data.rho.(scenario)(condition(2)))];
    feat_p_val_text = [condition(2) + ' p_val = ',num2str(Data.p_val.(scenario)(condition(2)))];
    text('normalized',[conj_rho_text,conj_p_val_text,feat_rho_text,feat_p_val_text],...
        'EdgeColor','k','BackgroundColor',[0.85 0.85 0.85] ,'VerticalAlignment','top');
    legend('conjunction' , 'feature','conjunction fit','feature fit','FontSize',10)
end

    