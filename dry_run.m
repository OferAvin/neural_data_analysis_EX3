%this function returns a vec of acc and rt for a dry run

%the slopes and intercepts of the distributions 
%where calculated by polyfit under the assumption of linearity on a real
%data which we ran.
function [acc_vec,rt_vec] = dry_run(cond,scenario,set_size,num_of_trails,acc_prob)
    rt_vec = zeros(1,num_of_trails);
    acc_vec = randsrc(1,num_of_trails,[0,1;acc_prob]);
    scenario0 = find(scenario == 0);
    scenario1 = find(scenario == 1);
    if cond == "conj"
        rt_scn1 = normrnd(0.08*set_size+0.87,0.03*set_size,[1,num_of_trails/2]);
        rt_scn0 = normrnd(0.12*set_size+0.6,0.02*set_size,[1,num_of_trails/2]);
    else 
        rt_scn1 = normrnd(0.024*set_size+0.78,0.01*set_size,[1,num_of_trails/2]);
        rt_scn0 = normrnd(0.04*set_size+0.68,0.007*set_size,[1,num_of_trails/2]);
    end
    rt_vec(scenario0) = rt_scn0;
    rt_vec(scenario1) = rt_scn1;
end