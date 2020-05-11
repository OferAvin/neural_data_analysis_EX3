function build_fig(block_type,has_target,target,non_target,target_color,non_target_color, x_vec,y_vec)
    shapes_num = block_type{2};
    if block_type{1} == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec)
    else
        feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec)
    end
end