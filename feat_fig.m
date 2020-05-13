function feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec)
    shapes = strings(1,shapes_num);
    if has_target == 1
       shapes(1:shapes_num-1) = non_target;
       shapes(shapes_num) = target;
       text(x_vec,y_vec,shapes,'Color',target_color);
    else
       shapes(1:shapes_num) = non_target;
       text(x_vec,y_vec,shapes,'Color',target_color);
    end
end