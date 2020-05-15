clc; clear;
%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
set(H,'Name','Visual Search Experiment');
set(H,'MenuBar','none');
set(H,'ToolBar','none');
set(H,'Color','w');
fontsize = 14;
axis off
expirament_instractions(fontsize);
%% experiment parameters
num_of_blocks = 8;
num_of_trails = 4;
max_time_in_sec = 4;
min_time_in_sec = 0.1;
min_correct_ans_per_block = 10;

cond = ["conj","feat"];
has_target = ["has_target", "no_target"];
set_sizes = [4,8,12,16];
num_of_sizes = length(set_sizes);
stimuli_shape = ["X", "O"];
color_vec = ["b","r"];

%% creating all data struct
Expirament = build_struct(num_of_blocks,cond,has_target,set_sizes,num_of_trails);
block_order = randperm(num_of_blocks);

%% collect data
for i = block_order   
    cur_block_name = (char("B"+i));
    Expirament.(cur_block_name) = run_block(Expirament.(cur_block_name),...
        stimuli_shape,color_vec,num_of_trails,fontsize);
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
    
    Expirament = calc_mean_sd_per_cond(Expirament,i,target_trails,has_target(1),cond,num_of_sizes);
    Expirament = calc_mean_sd_per_cond(Expirament,i,no_target_trails,has_target(2),cond,num_of_sizes);
  
end

% calculating correlation and p-value
[r_conj_target,p_conj_target] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.has_target{1});
[r_conj_no_target,p_conj_no_target] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.no_target{1});
[r_feat_target,p_feat_target] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.has_target{2});
[r_feat_no_target,p_feat_no_target] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.no_target{2});

Expirament.All_results.rho('conj','has_target') = {r_conj_target};
Expirament.All_results.rho('conj','no_target') = {r_conj_no_target};
Expirament.All_results.rho('feat','has_target') = {r_feat_target};
Expirament.All_results.rho('feat','no_target') = {r_feat_no_target};
 
Expirament.All_results.p_val('conj','has_target') = {p_conj_target};
Expirament.All_results.p_val('conj','no_target') = {p_conj_no_target};
Expirament.All_results.p_val('feat','has_target') = {p_feat_target};
Expirament.All_results.p_val('feat','no_target') = {p_feat_no_target};

close all force;


