function build_fig(block_type,has_target,target,non_target, x_vec,y_vec ,target_color)
    shapes_num = block_type{2};
    if block_type{1} == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec)
    else
        feat_fig(shapes_num,has_target,target_shape,non_target,x_vec,y_vec ,target_color)
    end
end