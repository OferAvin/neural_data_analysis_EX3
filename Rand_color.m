function[Target_color,none_target_color] = Rand_color(color_vec)
check = rand(1,1);
if check>0.5
    Target_color = color_vec(1);
    none_target_color = color_vec(2);
else
   Target_color = color_vec(2);
   none_target_color = color_vec(1);
end

