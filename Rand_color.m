%this function gets a two color vector and randomly returns one of them as target
%and the other as non-target
function[target_color,none_target_color] = rand_color(color_vec)
check = rand(1,1);
if check>0.5
    target_color = color_vec(1);
    none_target_color = color_vec(2);
else
    target_color = color_vec(2);
   none_target_color = color_vec(1);
end

