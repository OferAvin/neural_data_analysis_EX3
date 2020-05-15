%this function collects response time and marks correct and wrong responses
function[acc,rt] = trail_data(has_target)
	tic
	if has_target == 1
		correct = 'a';
	else
		correct = 'l';
	end
	 pause; key = get(gcf,'CurrentCharacter');
	 rt = toc;
	 acc = strcmpi(key,correct);
	 clf;
 end