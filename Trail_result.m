function[acc,rt] = trail_result(has_target)
tic
if has_target == "true"
    correct = 'a';
else
    correct = 'l';
end
 pause; key = get(gcf,'CurrentCharacter');
 rt = toc;
 acc = strcmpi(key,correct);
 clf;