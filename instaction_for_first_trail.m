function instaction_for_first_trail(target)
if target == 'X'
    message = sprintf(['Target stimulus is an X that is different from the'...
    ' rest\nPress "a" if target is present\nPress "l" if target is not present\nPress spacebar to start.']);
    text(0.5,0.5,message,'FontSize',14,'Units','normalized','horizontalAlignment','center')
    space_to_continue;
    clf
else
    message = sprintf(['Target stimulus is an O that is different from the'...
    ' rest\nPress "a" if target is present\nPress "l" if target is not present\nPress spacebar to start.']);
    text(0.5,0.5,message,'FontSize',14,'Units','normalized','horizontalAlignment','center')
    space_to_continue;
    clf
end

        
 