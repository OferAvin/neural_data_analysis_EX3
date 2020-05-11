function[x_vec,y_vec,Target_color,none_target_color] = fig_parameters(block_types,color_vec)
[x_vec,y_vec] = rand_location(block_types{2});
[Target_color,none_target_color] = Rand_color(color_vec);