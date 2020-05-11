
%function that presents the trials accourding to deff
function[rt,acc] = trial(block_info,target_yn,chosen_shape,not_chosen_shape,rand_color)

%getting num of elements and type of search
elmnts_num = str2num(block_info(1));
feat_or_conj = block_info(2);

%randomizing locations on screen
yl = randperm(100,elmnts_num).*0.01;
xl = randperm(100,elmnts_num).*0.01;

%randomizing colors and shapes
red_blue = ["r","b"];
chosen_color = red_blue(rand_color);
not_chosen_color = red_blue(find(red_blue ~= chosen_color,1));
shapes = cell(1,elmnts_num);

%feature search
if feat_or_conj == 'feat'
    if target_yn == 1 %target present
        shapes(1:elmnts_num-1) = {not_chosen_shape}; %creating the shapes vector
        shapes(elmnts_num) = {chosen_shape}; %adding the chosen shape
        tic
        text(xl,yl,shapes,'Color',chosen_color); %text shape accourding to random location 
        acc_chck = 'a';
        
    elseif target_yn == 0 %target absent
        shapes(1:end) = {not_chosen_shape}; %no target shape
        tic
        text(xl,yl,shapes,'Color',chosen_color);
        acc_chck = 'l';
        
    end 
    
% conjuction search    
elseif feat_or_conj == 'conj' 
    shapes(1:elmnts_num/2) = {not_chosen_shape}; %half of the shapes are not the chosen shape
    shapes(elmnts_num/2+1:end) = {chosen_shape}; %half are the chosen shape
    text_dis_1 = text(xl(1:elmnts_num/2),yl(1:elmnts_num/2),shapes(1:elmnts_num/2),'Color',chosen_color); %display distractors from other shape
    text_dis_2 = text(xl(elmnts_num/2+1:end-1),yl(elmnts_num/2+1:end-1),shapes(elmnts_num/2+1:end-1),'Color',not_chosen_color); %display distractors from other color
    if target_yn == 1 %target present
        tic
        text_target = text(xl(end),yl(end),shapes(end),'Color',chosen_color); %display target
        acc_chck = 'a';
        
    elseif target_yn == 0 %target absent
        tic
        text_target = text(xl(end),yl(end),shapes(end),'Color',not_chosen_color); %display last character as non target
        acc_chck = 'l';
       
    end 
end

 pause; key = get(gcf,'CurrentCharacter');
 rt = toc;
 acc = strcmpi(key,acc_chck);

clf
axis off;
    
    
    
   
    

    
    

