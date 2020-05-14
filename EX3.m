clc; clear;
%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
set(H,'Name','Visual Search Experiment');
set(H,'MenuBar','none');
set(H,'ToolBar','none');
set(H,'Color','w');
fontsize = 20;
axis off
inst = text(0.5,0.5,...
    {'Thank you for participating in the experiment.'  ' '  'In the following screens you will be presented with several shapes - X / O.'...
    'The shapes can be in differenet colors - red / blue.' 'The target will be determined at the start of each block.'...
    ' ' 'You are asked to response whether the target is displayed or not by pressing A for target present, and L for target absent on keyboard.'...
    'Make sure your keyboard language is set on english' ' ' 'Try to be as quick as possible while making sure to be right.' ...
    ' ' ' ' 'Press Spacebar to start the experiment.'}...
    ,'HorizontalAlignment' , 'center','FontSize',14);
space_to_continue;
clf;
%% experiment parameters
num_of_blocks = 8;
num_of_trails = 30;
max_time_in_sec = 4;
min_time_in_sec = 0.1;
min_correct_ans_per_block = 10;

cond = ["conj","feat"];
set_sizes = [4,8,12,16];
stimuli_shape = ["X", "O"];
color_vec = ["b","r"];

%% creating all data struct
Expirament = build_struct(num_of_blocks,cond,set_sizes,num_of_trails);
block_order = randperm(num_of_blocks);

%% collect data
for i = block_order   
    cur_block_name = (char("B"+i));
    Expirament.(cur_block_name) = run_block(Expirament.(cur_block_name),stimuli_shape,color_vec,num_of_trails);
end

%% pre processing

for i = 1:num_of_blocks
    cur_block_name = (char("B"+i));
    [Expirament.(cur_block_name),has_passed] = is_valid_block(Expirament.(cur_block_name),...
        min_correct_ans_per_block,max_time_in_sec,min_time_in_sec);
%     if has_passed == 0
%         error('not enough data');
%     end
end

%% Analisys

for i = 1:num_of_blocks
    cur_block_name = (char("B"+i));
    Cur_block = Expirament.(cur_block_name);
    
    target_trails = get_sub_vec_intersect(Cur_block.passed, 1,Cur_block.has_target, 1);     
    no_target_trails = get_sub_vec_intersect(Cur_block.passed, 1,Cur_block.has_target, 0);
    
    Cur_block = calc_mean_sd_per_cond(Cur_block,target_trails);
    Cur_block = calc_mean_sd_per_cond(Cur_block,no_target_trails);
    
    Expirament.(cur_block_name) = Cur_block; 
end

    
 close all force;

