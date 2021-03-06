clc; clear;
%% figure def
H = figure('units','normalized','position' ,[0 0 1 1]);
set(H,'Name','Visual Search Experiment');
set(H,'MenuBar','none');
set(H,'ToolBar','none');
set(H,'Color','w');
fontsize = 14;
axis off

%% Experiment parameters
num_of_blocks = 8;
num_of_trails = 30;
max_rt_in_sec = 4;
min_rt_in_sec = 0.1;
min_correct_ans_per_block = 20;
min_correct_ans = 160;

cond = ["conj","feat"];
scenario = ["has_target", "no_target"];
set_sizes = [4,8,12,16];
num_of_sizes = length(set_sizes);
stimuli_shape = ["X", "O"];
color_vec = ["b","r"];

run_mod = 1;                %0 - wet mode, 1 - dry mode
acc_prob = [0.25,0.75];     %probabilty for acc in dry mode

%% Plot Parameters
title = ["Target was Presented","Target was absent"];
axis_lables = ["Set Size","Response Time[sec]"];
results_text = ["Con P = ","Con R = ","Feat P = ","Feat R = "];
text_to_legend = ["Conjunction","Conjunction fit","Feature","Feature fit"];
y_lim = [0,max_rt_in_sec];
P1_cor1=[0.1,0.4,0.9]; P1_cor2=[0.8,0.6,0.3];
P2_cor1=[0.7,0.7,0.3]; P2_cor2=[0.2,0.4,0.1];
P3_cor1=[0.7,0.6,0.2]; P3_cor2=[0.8,0.2,0.6];
P4_cor1=[0.5,0.5,0.2]; P4_cor2=[0.8,0.1,0.3];

%% Expirament instractions
expirament_instractions(fontsize,run_mod)

%% creating all data structure
Expirament = build_struct(num_of_blocks,cond,scenario,set_sizes,num_of_trails);

%% collect data
block_order = randperm(num_of_blocks);          %determining bolck order randomly

for i = block_order                             %running through blocks by block_order
    cur_block_name = (char("B"+i));             
    Expirament.(cur_block_name) = run_block(Expirament.(cur_block_name),...
        stimuli_shape,color_vec,num_of_trails,fontsize,run_mod,acc_prob);
end

save('raw data' , 'Expirament'); 

%% pre processing
%checking for wrong/bad results, in case not enough good data will not 
%move on to analysis
count_valid = 0;
for i = 1:num_of_blocks
    cur_block_name = (char("B"+i));
    char_size = char("size_"+ Expirament.(cur_block_name).set_size);
    char_cond = char(Expirament.(cur_block_name).condition);
    
    [Expirament.(cur_block_name),has_passed,num_of_valid_ans] = ... 
        is_valid_block(Expirament.(cur_block_name),min_correct_ans_per_block,max_rt_in_sec,min_rt_in_sec);
    count_valid = count_valid + num_of_valid_ans;                     
    Expirament.All_results.passed_trails.(char_size)(char_cond) = num_of_valid_ans;

     if has_passed == 0             %check if block is valied
         error('not enough correct answer in one of the blocks');
     end
end
if count_valid < min_correct_ans    %check if expirament is valied
    error('not enough correct answer in the expirament');
end

        
%% Analisys
%calculating mean & SD
for i = 1:num_of_blocks
    cur_block_name = (char("B"+i));
    Cur_block = Expirament.(cur_block_name);
   
    % get valid trails by scenario
    inter1 = get_sub_vec_intersect(Cur_block.passed, 1,Cur_block.(scenario(1)), 1);     
    inter2 = get_sub_vec_intersect(Cur_block.passed, 1,Cur_block.(scenario(1)), 0);
    
    Expirament = calc_mean_sd_per_cond(Expirament,i,inter1,scenario(1),num_of_sizes);
    Expirament = calc_mean_sd_per_cond(Expirament,i,inter2,scenario(2),num_of_sizes);
  
end

% calculating correlation and p-value
[r1,p1] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.(scenario(1)){cond(1)});
[r2,p2] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.(scenario(2)){cond(1)});
[r3,p3] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.(scenario(1)){cond(2)});
[r4,p4] = calculat_pval_cor(set_sizes,Expirament.All_results.mean.(scenario(2)){cond(2)});

Expirament.All_results.rho(cond(1),scenario(1)) = {r1};
Expirament.All_results.rho(cond(1),scenario(2)) = {r2};
Expirament.All_results.rho(cond(2),scenario(1)) = {r3};
Expirament.All_results.rho(cond(2),scenario(2)) = {r4};
 
Expirament.All_results.p_val(cond(1),scenario(1)) = {p1};
Expirament.All_results.p_val(cond(1),scenario(2)) = {p2};
Expirament.All_results.p_val(cond(2),scenario(1)) = {p3};
Expirament.All_results.p_val(cond(2),scenario(2)) = {p4};

% fitting function for each condition and target
Expirament.All_results.fit.(scenario(1)){cond(1)} = ...
    linear_fit(set_sizes,Expirament.All_results.mean.(scenario(1)){cond(1)});
Expirament.All_results.fit.(scenario(2)){cond(1)} = ...
    linear_fit(set_sizes,Expirament.All_results.mean.(scenario(2)){cond(1)});
Expirament.All_results.fit.(scenario(1)){cond(2)} = ...
    linear_fit(set_sizes,Expirament.All_results.mean.(scenario(1)){cond(2)});
Expirament.All_results.fit.(scenario(2)){cond(2)} = ...
    linear_fit(set_sizes,Expirament.All_results.mean.(scenario(2)){cond(2)});

% save('post proccesing and analisys data', 'Expirament');
close all force;

%% Plotting
%has target scenario
figure('Color', 'white', 'Units', 'normalized', 'Position' ,[0 ,0, 1, 1]);
hold on;

plot_condition(Expirament.All_results,set_sizes,cond(1),scenario(1),...
    title(1),axis_lables,P1_cor1,P1_cor2,y_lim)
plot_condition(Expirament.All_results,set_sizes,cond(2),scenario(1),...
    title(1),axis_lables,P2_cor1,P2_cor2,y_lim)
add_text_to_figure(Expirament.All_results,cond,scenario(1),results_text,text_to_legend)

%no target scenario
figure('Color', 'white', 'Units', 'normalized', 'Position' ,[0 ,0, 1, 1]);
hold on;

plot_condition(Expirament.All_results,set_sizes,cond(1),scenario(2)...
    ,title(2),axis_lables,P3_cor1,P3_cor2,y_lim)
plot_condition(Expirament.All_results,set_sizes,cond(2),scenario(2)...
    ,title(2),axis_lables,P4_cor1,P4_cor2,y_lim)
add_text_to_figure(Expirament.All_results,cond,scenario(2),results_text,text_to_legend)