clc; clear;
%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
% space_to_continue;
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

[x_vec,y_vec,target_color,none_target_color] = fig_parameters(Expirament(i),color_vec);
build_fig(block_types{8},'true',"X", "O","blue","red", x_vec,y_vec)

