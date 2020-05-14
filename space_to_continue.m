%this function waits till the spacebar is pressed 
function space_to_continue
    while 1 == 1    
        pause; space = get(gcf,'CurrentCharacter');
        if space == ' '
            break;
        end 
    end 
end