function build_fig(block,has_target,target,non_target,target_color,non_target_color, x_vec,y_vec,num_of_trail)
    shapes_num = block.set_size;
    if num_of_trail==1
        instaction_for_first_trail(target);
    end
    if block.cond == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec)
    else
        feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec)
    end
end