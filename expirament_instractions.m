function expirament_instractions(fontsize)
    inst = text(0.5,0.5,...
        {'Thank you for participating in the experiment.'  ' '  'In the following screens you will be presented with several shapes - X / O.'...
        'The shapes can be in differenet colors - red / blue.' 'The target will be determined at the start of each block.'...
        ' ' 'You are asked to response whether the target is displayed or not by pressing "a" for target present, and "l" for target absent on keyboard.'...
        'Make sure your keyboard language is set on english' ' ' 'Try to be as quick as possible while making sure to be right.' ...
        ' ' ' ' 'Press Spacebar to start the experiment.'}...
        ,'HorizontalAlignment' , 'center','FontSize',fontsize);
    space_to_continue;
    clf;
end