%this function displays instracion if current trail is the first
function instaction_for_first_trail(target,cond,fontsize,run_mod)
    if cond == 'feat'
        message = sprintf(['Target stimulus is an %s \nPress "a" if target is present'...
            '\nPress "l" if target is not present\nPress spacebar to start.'],target);
    else
        message = sprintf(['Target stimulus is a unique %s which is different from the rest'...
            '\nPress "a" if target is present\nPress "l" if target is not present\nPress spacebar to start.'],target);
    end
    text(0.5,0.5,message,'FontSize',fontsize,'Units','normalized','horizontalAlignment','center')
    if run_mod == 0
        space_to_continue;
    else 
        pause(1);
    end
    clf;
    axis off
end
        
 