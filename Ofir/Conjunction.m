function [rt , acc , target_present]  = Conjunction(Set_size,Ntrials,fig, run_mode)
%Set_size - vector of set sizes to run
%Ntrials- number of trials per block
%fig - active figure.
%run_mode - dry running or not

stim_sz = 16; %stimulus text size
%allocations
rt = zeros(1,Ntrials);
acc = zeros(1,Ntrials);
%random vector for target on or off.
target_present = randsample([zeros(1,Ntrials/2),ones(1,Ntrials/2)],Ntrials);
%Choosing target X/O randomly.
target_shape = randsample([79,88], 2); %79 is O, 88 is X.
target_color = randsample(['r','b'],2); % r for red, b for blue.
%Ploting instructions for block.
h =fig;
figure(h)
if target_shape(1) == 79 && target_color(1) == 'r'
    text(0.5,0.5, {'Target stimulus is a red O ' 'press A if the target is presented, press L if target is not presented' 'Press Spacebar to start'},'HorizontalAlignment' , 'center','FontSize',16);
elseif target_shape(1) == 79 && target_color(1) == 'b'
    text(0.5,0.5, {'Target stimulus is a blue O ' 'press A if the target is presented, press L if target is not presented' 'Press Spacebar to start'},'HorizontalAlignment' , 'center','FontSize',16);
elseif target_shape(1) == 88 && target_color(1) == 'r'
    text(0.5,0.5, {'Target stimulus is a red X ' 'press A if the target is presented, press L if target is not presented' 'Press Spacebar to start'},'HorizontalAlignment' , 'center','FontSize',16);
elseif target_shape(1) == 88 && target_color(1) == 'b'
    text(0.5,0.5, {'Target stimulus is a blue X ' 'press A if the target is presented, press L if target is not presented' 'Press Spacebar to start'},'HorizontalAlignment' , 'center','FontSize',16);
end

if ~run_mode
    SpaceToRun(h);
else
    pause(1)
end
clf
axis off


% Looping for 30 trials in block.
for i = 1:Ntrials
    
    %Random Cordinates for stimulus.
    Locations(:,1) = randperm(20,Set_size)/20; %Random x cordinates
    Locations(:,2) = randperm(20,Set_size)/20; %Random y cordinates
    %Plotting stimulus.
    if target_present(i) == 1
        cr = 'A';
        distractor1 = text(Locations(2:(Set_size/2),1),Locations(2:(Set_size/2),2),char(target_shape(1)) , 'color',target_color(2) , 'Fontsize', stim_sz);
        distractor2 = text(Locations((Set_size/2)+1:end,1),Locations((Set_size/2)+1:end,2),char(target_shape(2)) , 'color',target_color(1) , 'Fontsize', stim_sz);
        target =  text(Locations(1,1),Locations(1,2),char(target_shape(1)), 'color',target_color(1) , 'Fontsize', stim_sz);
    else
        distractor1 = text(Locations(1:Set_size/2,1),Locations(1:Set_size/2,2),char(target_shape(1)) , 'color',target_color(2) , 'Fontsize', stim_sz);
        distractor2 = text(Locations((Set_size/2)+1:end,1),Locations((Set_size/2)+1:end,2),char(target_shape(2)) , 'color',target_color(1) , 'Fontsize', stim_sz);
        cr= 'L';
    end
    
    
    %Response time and accuracy.
    if run_mode
        [res_t , robo_key] = robotrick(Set_size , cr , 'Conjunction' , target_present(i));
%         pause(res_t)
        rt(i) = res_t;
        acc(i) = strcmpi(robo_key ,cr);
    else
        tic
        pause; key= h.CurrentCharacter;
        rt(i)=toc;
        acc(i)=strcmpi(key,cr);
    end
    %clearing figure
    clf
    axis off
    %Interleave between trials
    inter = randi([100 , 200])/1000; % Random mili seconds for interleave trials.
%     pause(inter)
end
end
