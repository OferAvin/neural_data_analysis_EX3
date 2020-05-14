function  SpaceToRun(fig)
%fig - which figure is active.
CurKey =0 ;
while CurKey == 0
     pause ; key= fig.CurrentCharacter;
    CurKey = strcmp(key,' ');
end
