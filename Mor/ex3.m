
clc; clear;

%% figure def
f = figure('units','normalized','outerposition' ,[0 0 1 1]);
set(f,'Name','Visual Search Experiment');
set(f,'MenuBar','none');
set(f,'ToolBar','none');
set(f,'Color',[0.8 0.8 0.8]);
fontsize = 20;
% welcome_pic = imread('תמונת ניסוי.jpg');

%% loop through entire experiment
while 1
%welcome pic and wait till user spacebar
% image(welcome_pic); 
axis off;
wait_till_spacebar;
clf;
axis off;

%% experiment part

%building the blocks manualy
block_data(1,:) = [4, "conj"];
block_data(2,:) = [8, "conj"];
block_data(3,:) = [12, "conj"];
block_data(4,:) = [16, "conj"];
block_data(5,:) = [4, "feat"];
block_data(6,:) = [8, "feat"];
block_data(7,:) = [12, "feat"];
block_data(8,:) = [16, "feat"];

%other variables
trial_num = 30;
block_num = length(block_data);
run_mode = 0;

%alocating memory
trial_data = struct;
trial_data.acc = cell(1,block_num);
trial_data.rt = cell(1,block_num);

trial_data.acc_dry = randsrc(block_num,trial_num,[1 0; 0.85 0.15]);
trial_data.rt_dry = cell(1,block_num);


%randomize block order
block_order = randperm(block_num);

%randomize shape order
xo = char(79,79,79,79,88,88,88,88);
shape_order = randperm(block_num);

%randomize target
rand_yn = randsrc(block_num,trial_num,[1 0]);
rand_color = randsrc(block_num,trial_num,[1 2]);

%loop through the blocks
for i = 1:block_num
    chosen_shape = xo(shape_order(i)); 
    not_chosen_shape = xo(find(xo ~= chosen_shape,1));
    %text this blocks target's shape
    text(0.5,0.5,['new block' 'the chosen target shape is ' string(chosen_shape),...
        'press any key to continue'],'FontSize',fontsize,'FontName','Calibri Light',...
        'HorizontalAlignment','center'); 
    wait_till_spacebar;
    clf;
    axis off;
    for j = 1:trial_num %run the block's trial according to block def
        [trial_data.rt{i}(j),trial_data.acc{i}(j)] = trial(block_data(block_order(i),:),rand_yn(i,j),chosen_shape,not_chosen_shape,rand_color(i,j));
    end
end 

save('initial_data.mat','-struct', 'trial_data');

%% filer out irrelevants

%helping var
flag = 0;
time_lim = 4;
min_trials_block = 20;
min_trials_overall  = 160;

%loop through blocks
for i = 1:block_num
    idx_acc = find(trial_data.acc{i} == 0); %find wrong trials
    idx_rt = find(trial_data.rt{i} > time_lim); %find too long trials
    trial_data.rt{i}(union(idx_acc,idx_rt)) = []; %delete wrong and too long trials from data
    trial_data.acc{i}(union(idx_acc,idx_rt)) = [];
    trial_data.target{i} = rand_yn(i,setdiff(1:end,[union(idx_acc,idx_rt)])); %create a cell array for target present or absent of the remainig trials
   
    if numel(trial_data.rt{i}) < min_trials_block %check if enough trials per block
        flag = 1;
        break
    end
    
end 

if sum(cellfun(@length,trial_data.rt)) < min_trials_overall %check if enough trials overall
        flag = 1;
end 

if flag == 1 %if not enough trials
    %text to let the user know not enough trials and how to continue
    text(0.5,0.5,{'not enough valid trials', 'do you want to try again?',...
        ' ' , 'press Y for yes or N for no'},'FontSize',fontsize,'FontName'...
        ,'Calibri Light','HorizontalAlignment','center');
    pause; key = get(gcf,'CurrentCharacter'); %get user answer
    if strcmpi(key,'n') %if user doesnt want to carry on- break the while loop
        break;
    end
elseif flag == 0 %if enough trials break the while loop
    break;
end 
end 

save('filtered_data.mat','-struct', 'trial_data'); %save filtered data


%% plots

plot_data = struct;

%find target trial index and non target trial index
target_trials_idx = cellfun(@(x) find(x == 1),trial_data.target,'UniformOutput',0);
non_target_trials_idx = cellfun(@(x) find(x == 0),trial_data.target,'UniformOutput',0);

% devide rt to target and non target
trial_data.target_rt = arrayfun(@(x) trial_data.rt{x}(target_trials_idx{x}),block_order,'UniformOutput',0);
trial_data.non_target_rt = arrayfun(@(x) trial_data.rt{x}(non_target_trials_idx{x}),block_order,'UniformOutput',0);

%structure the data devided to target\non target, conj\feat for mean and
%std
plot_data.target_mean_conj = cellfun(@mean,trial_data.target_rt(1:4));
plot_data.target_mean_feat = cellfun(@mean,trial_data.target_rt(5:8));
plot_data.target_std_conj = cellfun(@std,trial_data.target_rt(1:4));
plot_data.target_std_feat = cellfun(@std,trial_data.target_rt(5:8));

plot_data.non_target_mean_conj = cellfun(@mean,trial_data.non_target_rt(1:4));
plot_data.non_target_mean_feat = cellfun(@mean,trial_data.non_target_rt(5:8));
plot_data.non_target_std_conj = cellfun(@std,trial_data.non_target_rt(1:4));
plot_data.non_target_std_feat = cellfun(@std,trial_data.non_target_rt(5:8));

plot_data.set_size = double(block_data(1:4,1))';

%first figure- target present- plot conj and feat, polynom fit, and pearson
%correlation
figure;
set(gcf,'units','centimeters','position',[5,0,25,15]) ;

subplot(1,3,1:2);

%plot errorbar for conj and feat search
errorbar(plot_data.set_size,plot_data.target_mean_conj,plot_data.target_std_conj,'-b'); hold on;
errorbar(plot_data.set_size,plot_data.target_mean_feat,plot_data.target_std_feat,'-r'); hold on;
xlabel('set size'); ylabel('reaction time mean [sec]');
title('Currectly Identified the Presence of Target');

%get data for correlation and polynom
[plot_data.rho{1},plot_data.pval{1},plot_data.poly{1}] = stats(plot_data.set_size,plot_data.target_mean_conj);
[plot_data.rho{2},plot_data.pval{2},plot_data.poly{2}] = stats(plot_data.set_size,plot_data.target_mean_feat);
plot(plot_data.set_size,plot_data.poly{1},'--g'); hold on; %plot the fit polynom
plot(plot_data.set_size,plot_data.poly{2},'--m'); hold on;
legend('conjuction search','feature search','conjuction polynom fit','feature polynom fit');

%display correlation info
subplot(1,3,3);
axis off;
str = ["conjunction search \rho:", num2str(plot_data.rho{1}), "pval:" ,...
    num2str(plot_data.pval{1}); "feature search \rho:", num2str(plot_data.rho{2}), "pval:", num2str(plot_data.pval{2})];
annotation('textbox',[.7 .5 .3 .3],'String',str','FitBoxToText','on');

%second figure- target absent- plot conj and feat, polynom fit, and pearson
%correlation
figure;
set(gcf,'units','centimeters','position',[5,0,25,15]) ;

%plot errorbar for conj and feat search
subplot(1,3,1:2);
errorbar(plot_data.set_size,plot_data.non_target_mean_conj,plot_data.non_target_std_conj,'-b'); hold on;
errorbar(plot_data.set_size,plot_data.non_target_mean_feat,plot_data.non_target_std_conj,'-r'); hold on;
xlabel('set size'); ylabel('reaction time mean [sec]');
title('Currectly Identified the Absence of Target');

%get data for correlation and polynom
[plot_data.rho{3},plot_data.pval{3},plot_data.poly{3}] = stats(plot_data.set_size,plot_data.non_target_mean_conj);
[plot_data.rho{4},plot_data.pval{4},plot_data.poly{4}] = stats(plot_data.set_size,plot_data.non_target_mean_feat);
plot(plot_data.set_size,plot_data.poly{3},'--g'); hold on; %plot the fit polynom
plot(plot_data.set_size,plot_data.poly{4},'--m'); hold on;
legend('conjuction search','feature search','conjuction polynom fit','feature polynom fit');

%display correlation info
subplot(1,3,3);
axis off;
str = ["conjunction search \rho:", num2str(plot_data.rho{3}), "pval:" ,...
    num2str(plot_data.pval{3}); "feature search \rho:", num2str(plot_data.rho{4}),...
    "pval:", num2str(plot_data.pval{4})];
annotation('textbox',[.7 .5 .3 .3],'String',str','FitBoxToText','on');



