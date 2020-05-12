function[x_vec,y_vec,Target_color,none_target_color] = fig_parameters(block,color_vec)
[x_vec,y_vec] = rand_location(block.set_size);
[Target_color,none_target_color] = Rand_color(color_vec);