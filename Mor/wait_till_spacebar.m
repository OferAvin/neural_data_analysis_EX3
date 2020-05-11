%function that pauses figure till user presses spacebar
function[] = wait_till_spacebar


pause; space = get(gcf,'CurrentCharacter'); 

while space ~= ' '
    pause; space = get(gcf,'CurrentCharacter');
    if space == ' '
        break;
    end 
end 