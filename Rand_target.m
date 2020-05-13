function[target_shape,none_target_shape,has_target] = rand_target(stimuli_shape,num_of_trails)
check = rand(1,1);
if check>0.5
    target_shape = stimuli_shape(1);
    none_target_shape = stimuli_shape(2);
else
    target_shape = stimuli_shape(2);
    none_target_shape = stimuli_shape(1);
end
has_target = mod(randperm(num_of_trails),2)==0;

