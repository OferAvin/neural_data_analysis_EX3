function add_text_to_figure(Data,condition,scenario)
    hold on;
    conj_rho_text = condition(1) + ' rho = ' + num2str(Data.rho.(scenario)(condition(1)));
    conj_p_val_text = condition(1) + ' p-val = ' + num2str(Data.p_val.(scenario)(condition(1)));
    feat_rho_text = condition(2) + ' rho = ' + num2str(Data.rho.(scenario)(condition(2)));
    feat_p_val_text = condition(2) + ' p-val = ' + num2str(Data.p_val.(scenario)(condition(2)));
    
    txt = {conj_rho_text, conj_p_val_text, feat_rho_text, feat_p_val_text};
    text(13,1.5,txt ,'VerticalAlignment','top','FontSize',7);
    legend('conjunction' , 'feature','conjunction fit','feature fit','aaa','bbbb','location','northwest','FontSize',7)
end

    