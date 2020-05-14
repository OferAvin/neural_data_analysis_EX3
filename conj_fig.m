%this function builds a conjunction figure
function conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec)
    shapes = strings(1,shapes_num);									
    shapes(1:shapes_num/2) = target;
    shapes(shapes_num/2+1:end) = non_target;
    if has_target == 1
        text(x_vec(2:shapes_num/2),y_vec(2:shapes_num/2),...
        shapes(2:shapes_num/2),'Color',non_target_color);
        text(x_vec(1),y_vec(1),shapes(1),'Color',target_color);
    else
        text(x_vec(1:shapes_num/2),y_vec(1:shapes_num/2),...
        shapes(1:shapes_num/2),'Color',non_target_color);
    end
    text(x_vec(shapes_num/2+1:end),y_vec(shapes_num/2+1:end),...
        shapes(shapes_num/2+1:end),'Color',target_color);    
end
