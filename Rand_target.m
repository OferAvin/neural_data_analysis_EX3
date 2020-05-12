function[Target_shape,none_target_shape,has_target] = Rand_target(stimuli_shape)
%stimuli_shape = ["X", "O"] ;
check = rand(1,1);
if check>0.5
    Target_shape = stimuli_shape(1);
    none_target_shape = stimuli_shape(2);
else
   Target_shape = stimuli_shape(2);
   none_target_shape = stimuli_shape(1);
end
has_target = mod(randperm(30),2)==0;

