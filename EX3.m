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
num_of_trails = 30;
max_time_in_sec = 4;
min_time_in_sec = 0.2;
min_correct_ans_per_block = 10;

cond = ["conj","feat"];
set_sizes = [4,8,12,16];
stimuli_shlape = ["X", "O"];
color_vec = ["b","r"];

Expirament = build_struct(num_of_blocks,cond,set_sizes,num_of_trails);

block_order = randperm(num_of_blocks);

for i = block_order   
    cur_block = (char("B"+i));
    Expirament.(cur_block) = run_block(Expirament.(cur_block),stimuli_shape,color_vec,num_of_trails);
end
 close all force;

