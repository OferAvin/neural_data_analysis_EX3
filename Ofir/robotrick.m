function [res_t , robo_key] = robotrick( current_set , cr , cond , target)
%current_set - the current block set size.
%cr - correct key for current trial.
%cond - search condition.
%target- is target present (1) or absent (0) in current trial.


% picking the response time to the trial.
%times will be drawn from poisson distribution (no negative numbers like
%normal)
if strcmpi( cond , 'Feature') == 1
    res_t = poissrnd(5.5)/10; %Feature search is not affected by set size or target present/absent.
elseif strcmpi( cond , 'Condition') == 0
    if target == 1
        res_t = poissrnd(6+current_set*0.3)/10; %Conjunction search is affected by set size.
    else
        res_t = poissrnd(6+current_set*0.6)/10; %bigger slope if target absent.
    end
end

%checking if the robot will answer accurately- 95% success rate.
chance = rand;
if chance > 0.05
    robo_key = cr; %correct key
else
    robo_key = 'w'; %wrong key
end

