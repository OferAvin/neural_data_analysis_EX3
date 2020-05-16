%this function run all trails of the specified block,
%it determines the target shape and the figure parameters(locations,colors),
%builds the figures and collects the data
function Block = run_block(Block,shapes_vec,color_vec,num_of_trails,fontsize)
    [target_shape,none_target_shape] = rand_two_elements(shapes_vec);   %choose target randomly
    scenario_vec = rand_elements_eq(num_of_trails,2);                   %randomize scenario order
    Block.has_target = scenario_vec';
    
    for i = 1:num_of_trails
        [x_vec,y_vec,target_color,none_target_color] =...
            fig_parameters(Block,color_vec);                            %determining locations and target color
        
        build_fig(Block,scenario_vec(i),target_shape,none_target_shape,...
            target_color,none_target_color,i, x_vec,y_vec,fontsize);    %show trail figure
        
        [acc,rt] = trail_data(scenario_vec(i));                         %collecting data from subject
        Block.acc(i) = acc;
        Block.rt(i) = rt;
    end
end