clc; clear;
%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
space_to_continue;
set(H,'Name','Visual Search Experiment');
set(H,'MenuBar','none');
set(H,'ToolBar','none');
set(H,'Color','w');
fontsize = 20;
axis off

%% experiment parameters
num_of_blocks = 8;
trial_num = 30;

cond = ["conj","feat"];
set_sizes = [4,8,12,16];
stimuli_shape = ["X", "O"];
color_vec = ["b","r"];

Expirament = build_struct(num_of_blocks,cond,set_sizes,trial_num);

block_order = randperm(num_of_blocks);

for i = block_order   
    cur_block = (char("B"+i));
    [x_vec,y_vec,target_color,none_target_color] = fig_parameters(Expirament.(cur_block),color_vec);
    build_fig(Expirament.(cur_block),'true',"X", "O","blue","red",1, x_vec,y_vec);
    [acc,rt] = trail_result('true');
    Expirament.(cur_block).acc = acc;
    Expirament.(cur_block).rt = rt;
end
close;

