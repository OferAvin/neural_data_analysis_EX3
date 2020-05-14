%this function run all trails of the specified block,
%it determines the target shape and the figure parameters(locations,colors),
%builds the figures and collects the data
function Block = run_block(Block,shapes_vec,color_vec,num_of_trails)
    [target_shape,none_target_shape] = rand_two_elements(shapes_vec);
    has_target_vec = rand_elements_eq(num_of_trails,2);
    Block.has_target = has_target_vec';
    for i = 1:num_of_trails
        [x_vec,y_vec,target_color,none_target_color] = fig_parameters(Block,color_vec);
        build_fig(Block,has_target_vec(i),target_shape,none_target_shape,...
            target_color,none_target_color,i, x_vec,y_vec);
        [acc,rt] = trail_result(has_target_vec(i));
        Block.acc(i) = acc;
        Block.rt(i) = rt;
    end
end