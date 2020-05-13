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
stimuli_shape = ["X", "O"];
color_vec = ["b","r"];

Expirament = build_struct(num_of_blocks,cond,set_sizes,num_of_trails);

block_order = randperm(num_of_blocks);

for i = block_order   
    cur_block_name = (char("B"+i));
    [Expirament.(cur_block_name),Expirament.(cur_block_name).has_target] = run_block(Expirament.(cur_block_name),stimuli_shape,color_vec,num_of_trails);
end

%% pre processing

for i = 1:num_of_blocks
    cur_block_name = (char("B"+i));
    [Expirament.(cur_block_name),has_passed] = is_valid_block(Expirament.(cur_block_name),min_correct_ans_per_block,...
        max_time_in_sec,min_time_in_sec);
    if has_passed == 0
        error('not enough data');
    end
end

%% Analisys

cur_block_name = (char("B"+i));
target_trails = get_sub_vec_intersect(Expirament.(cur_block_name).pass, 1,...
    Expirament.(cur_block_name).has_target, 1);
no_target_trails = get_sub_vec_intersect(Expirament.(cur_block_name).pass, 1,...
    Expirament.(cur_block_name).has_target, 0);

 close all force;


