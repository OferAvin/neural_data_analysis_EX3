function add_text_to_figure(Data,condition,scenario,text_to_results,text_to_legend)
    hold on;
    conj_rho_text = text_to_results(2) + num2str(Data.rho.(scenario)(condition(1)));
    conj_p_val_text = text_to_results(1) + num2str(Data.p_val.(scenario)(condition(1)));
    feat_rho_text = text_to_results(4) + num2str(Data.rho.(scenario)(condition(2)));
    feat_p_val_text =text_to_results(3) + num2str(Data.p_val.(scenario)(condition(2)));
    
    txt = {conj_rho_text, conj_p_val_text, feat_rho_text, feat_p_val_text};
    text(14.5,0.9,txt,'EdgeColor','b','VerticalAlignment','top','FontSize',10);
    legend(text_to_legend(1),text_to_legend(2),text_to_legend(3),text_to_legend(4)...
        ,'location','northwest','FontSize',10)
end

    