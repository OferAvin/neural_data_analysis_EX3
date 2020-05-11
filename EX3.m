clc; clear;

%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
set(H,'Name','Visual Search Experiment');
set(H,'MenuBar','none');
set(H,'ToolBar','none');
set(H,'Color','w');
fontsize = 20;
axis off

%% experiment parameters
block_types = {{"conj",4},{"conj",8},{"conj",12},{"conj",16},{"feat",4},{"feat",8},{"feat",12},{"feat",16}};
trial_num = 30;
block_num = length(block_types);
stimuli_shape = ["X", "O"];
color_vec = ["blue","red"];
[x_vec,y_vec,Target_color,none_target_color] = fig_parameters(block_types{1},color_vec);
