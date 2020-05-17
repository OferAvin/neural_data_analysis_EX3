%this function creates the trail figure, it uses conj_fig 
%in case its a conjunction condition and feat_fig for feature condition
%the function gets the Block, trail type(target/not-target) - has_target,
%target,color and locations of all shapes
function build_fig(Block,has_target,target,non_target,target_color,non_target_color,num_of_trail, x_vec,y_vec,fontsize,run_mod)
    shapes_num = Block.set_size;
    if num_of_trail==1
        axis off
        instaction_for_first_trail(target,Block.condition,fontsize,run_mod);
    end
    if Block.condition == "conj"
        conj_fig(shapes_num,has_target,target,non_target,target_color,non_target_color,x_vec,y_vec);
    else
        feat_fig(shapes_num,has_target,target,non_target,target_color,x_vec,y_vec);
    end
    axis off
end