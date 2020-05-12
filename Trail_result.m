function[acc,rt] = Trail_result(has_target)
tic
if has_target == "true"
    correct = 'a';
else
    correct = 'l';
end
 pause; key = get(gcf,'CurrentCharacter');
 acc = strcmpi(key,correct);
 rt = toc;