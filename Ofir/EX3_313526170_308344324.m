clear;close all; clc;

%% Dry run mode-
run_mode = 1 ; %if you want to dry run set this variable to 1, wet run set it to 0.

%% Setting parametrs
Ntrials = 30; %pick number of trials per block.
set_sz_dt = 4; %choose diffrence between set sizes.
Nsets = 4; %choose number of sets per condition.
set_sz  = set_sz_dt:set_sz_dt:set_sz_dt*Nsets;
Nblocks = 2*Nsets; %Number of total blocks.
max_rt = 3; %What is the maximun legible response time in seconds.

%Number of minimum legible trials for running analysis:
block_min = 20;
total_min = 160;

%% Experiment
h = figure('units','normalized', 'position', [0 ,0, 1, 1]);
axis off
h.Name = 'Visual Search Experiment';
h.Color = 'w';
h.MenuBar = 'none';
h.ToolBar = 'none';

% Blocks order- row 1 is the set size, row 2 is condition.
order(1,:) = [set_sz,set_sz]; %each condition set sizes
order(2,:) = [zeros(1,Nsets),ones(1,Nsets)]; %zero for feature, one for conjunction
%Random blocks order
shuffle = randperm(Nblocks);
order = order(:,shuffle);

%Greeting and instructions.
inst = text(0.5,0.5,...
    {'Thank you for participating in the experiment.'  ' '  'In the following screens you will be presented with several shapes - X / O.'...
    'The shapes can be in differenet colors - red / blue.' 'The target will be determined at the start of each block.'...
    ' ' 'You are asked to response whether the target is displayed or not by pressing A for target on, and L for target off on keyboard.'...
    'Make sure your keyboard language is set on english' ' ' 'Try to be as quick as possible while making sure to be right.' ...
    ' ' ' ' 'Press Spacebar to start the experiment.'}...
    ,'HorizontalAlignment' , 'center','FontSize',14);
if ~run_mode
    SpaceToRun(h);
else
    pause(1)
end
clf
axis off

%Allocations
feature_dat = zeros(3,Ntrials, Nsets);
conjunction_dat = zeros(3,Ntrials,Nsets);

%Counting number of each condition blocks that has been executed.
F = 0; C = 0;

for i = 1:Nblocks
    if order(2,i) == 0
        %Feature block.
        F = F+1;
        [feature_dat(1,:,F), feature_dat(2,:,F), feature_dat(3,:,F)] = ...
            Feature(order(1,i), Ntrials, h, run_mode);
    else
        %Conjunction block.
        C = C+1;
        [conjunction_dat(1,:,C),conjunction_dat(2,:,C),conjunction_dat(3,:,C)] =...
            Conjunction(order(1,i), Ntrials, h, run_mode);
    end
end

%Saving raw data.
save('Feature raw' , 'feature_dat')
save('Conjunction raw' , 'conjunction_dat')
save('Blocks order' , 'order')
%%  Filtering from the data incorrect response and long RT trials.
feature_dat = myfilter(feature_dat,max_rt);
conjunction_dat = myfilter(conjunction_dat,max_rt);

%% Analysis
%counting legible trials per block.
conjunction_blocks  = reshape(sum(conjunction_dat(2,:,:) == 1), 1,Nsets); %Number of each block legible trials conjunction condition.
feature_blocks = reshape(sum(feature_dat(2,:,:) == 1), 1,Nsets); %Number of each block legible trials feature condition.
total_trials = sum(conjunction_blocks) + sum(feature_blocks); %Number of total legible trials.

% Arranging by set size
%getting each condition presented blocks order.
f_idx = order(2,:) == 0;
f_order = order(1,f_idx);
c_idx = order(2,:) == 1;
c_order = order(1,c_idx);

% and arranging
[~ , f_blocks] = sort(f_order);
[~ , c_blocks] = sort(c_order);
feature_blocks = feature_blocks(f_blocks);
conjunction_blocks = conjunction_blocks(c_blocks);

% Conditions to continue analysis:

% Each bluck needs at least 20 legible trials after filtering.
if ~isempty(find(conjunction_blocks <20 , 1)) || ~isempty(find(feature_blocks <block_min , 1))
    error(['One or more blocks have less then ' num2str(block_min) ' legit trials. please run experiment again.'])
end

% Total number of legible trials needs to be atleast 160.
if total_trials < total_min
    error(['less then ' num2str(total_min) ' total legit trials. please run experiment again.'])
end

[F_off_m, F_on_m, F_off_std, F_on_std] = myanalysis(set_sz_dt, feature_dat , f_order);
[C_off_m, C_on_m, C_off_std, C_on_std] = myanalysis(set_sz_dt, conjunction_dat , c_order);

% Pearson's correlation
cori = {'rho' , 'pval' , 'significant' };
[F_off_rho , F_off_p] = corr(F_off_m' , set_sz');
[F_on_rho , F_on_p] = corr(F_on_m' , set_sz');
[C_on_rho ,C_on_p] = corr(C_on_m' , set_sz');
[C_off_rho , C_off_p] = corr(C_off_m' , set_sz');

cori{1} = [F_off_rho , F_on_rho , C_off_rho, C_on_rho];
cori{2} = [F_off_p, F_on_p , C_off_p , C_on_p];

%significant check
significant = cori{2};
sig = find(significant < 0.05) ;
insig = find(significant >= 0.05);

%significant assignment
significant = string(significant);
significant(sig) = 'Significant';
significant(insig) = 'Insiginificant';
cori{3} = significant;

% fitting a linear curve
liny = {'slope' , 'fit'};
[F_off_slope, F_off_line] = linfit(set_sz,F_off_m);
[F_on_slope , F_on_line] = linfit(set_sz,F_on_m);
[C_off_slope , C_off_line] = linfit(set_sz,C_off_m);
[C_on_slope , C_on_line] = linfit(set_sz,C_on_m);

liny{1} = [F_off_slope ,F_on_slope ,C_off_slope, C_on_slope];
liny{2} = [ F_off_line; F_on_line ; C_off_line; C_on_line];

%% Plots
% Without target plot.
fig2 = figure( 'units' , 'normalized' , 'position', [0, 0, 1, 1]);
myplot('off' , F_off_m , F_off_std , C_off_m ,C_off_std , set_sz , liny{2}(1,:), liny{2}(3,:) , liny{1}(1)...
    ,liny{1}(3) ,  cori{1}(1) , cori{1}(3) , cori{3}(1) , cori{3}(3))

% With target plot.
fig3 = figure( 'units' , 'normalized' , 'position', [0, 0, 1, 1]);
myplot('on' , F_on_m , F_on_std , C_on_m ,C_on_std , set_sz , liny{2}(2,:), liny{2}(4,:) , liny{1}(2)...
    ,liny{1}(4) ,  cori{1}(2) , cori{1}(4) , cori{3}(2) , cori{3}(4))

%% Table
names = {'Set size' , 'Feature block''s legible trials' , 'Conjunction block''s legible trials'};
table(set_sz' , feature_blocks' , conjunction_blocks' ,'VariableNames' , names)