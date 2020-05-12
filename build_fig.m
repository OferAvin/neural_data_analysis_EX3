function build_fig(block,has_target,target,non_target,target_color,non_target_color, x_vec,y_vec)
    shapes_num = block.set_size;
    if block.cond == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec)
    else
        feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec)
    end
end