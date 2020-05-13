function Block = run_block(Block,shapes_vec,color_vec,num_of_trails)
    [target_shape,none_target_shape,has_target_vec] = rand_target(shapes_vec,num_of_trails);
    for i = 1:num_of_trails
        [x_vec,y_vec,target_color,none_target_color] = fig_parameters(Block,color_vec);
        build_fig(Block,has_target_vec(i),target_shape,none_target_shape,...
            target_color,none_target_color,i, x_vec,y_vec);
        [acc,rt] = trail_result('true');
        Block.acc(i) = acc;
        Block.rt(i) = rt;
    end
end