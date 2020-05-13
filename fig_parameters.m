function[x_vec,y_vec,target_color,none_target_color] = fig_parameters(block,color_vec)
[x_vec,y_vec] = rand_location(block.set_size);
[target_color,none_target_color] = rand_color(color_vec);