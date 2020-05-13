function build_fig(block,has_target,target,non_target,target_color,non_target_color,num_of_trail, x_vec,y_vec)
    shapes_num = block.set_size;
    if num_of_trail==1
        axis off
        instaction_for_first_trail(target);
    end
    if block.condition == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec);
    else
        feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec);
    end
    axis off
end