function[target_shape,none_target_shape,has_target] = rand_target(stimuli_shape)
%stimuli_shape = ["X", "O"] ;
check = rand(1,1);
if check>0.5
    target_shape = stimuli_shape(1);
    none_target_shape = stimuli_shape(2);
else
   target_shape = stimuli_shape(2);
   none_target_shape = stimuli_shape(1);
end
has_target = mod(randperm(30),2)==0;

