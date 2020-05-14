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
    [r_with_target,p_with_target] = calculat_pval_cor(set_sizes,Cur_block.results('mean','has_target'));
    [r_no_target,p_no_target] = calculat_pval_cor(set_sizes,Cur_block.results('mean','no_target'));
    Expirament.All_results.rho(Cur_block.condition,'has_target') = r_with_target;
    Expirament.All_results.rho(Cur_block.condition,'no_target') = r_no_target;
    Expirament.All_results.p_val(Cur_block.condition,'has_target') = p_with_target;
    Expirament.All_results.p_val(Cur_block.condition,'no_target') = p_no_target;
end

%collecting data for the plots
[mean_target_F,mean_no_target_F,SD_target_F,SD_no_target_F] = collecting_data_by_search_type(Expirament,num_of_blocks,'feat');
[mean_target_C,mean_no_target_C,SD_target_C,SD_no_target_C] = collecting_data_by_search_type(Expirament,num_of_blocks,'conj');   
 close all force;

