function [mean_off , mean_on , std_off , std_on] = myanalysis(set_sz_dt, dat , blocks_order)
%order -order in which blocks was presented.
%dat - data for analysis.
%blocks_order - the order of blocks set sizes that was presented.




% getting variabels from data.
Nsets = size(dat,3);

%checking the order of the set size per condition that was displayed.


%finding trials with taget on/off.
target_on = dat(3,:,:) == 1;
target_off = dat(3,:,:) == 0;

% allocations:
mean_on = zeros(1,Nsets);
mean_off = zeros(1,Nsets);
std_on = zeros(1,Nsets);
std_off = zeros(1,Nsets);

%Calculating:
for j = 1:Nsets
    mean_on(j) = nanmean(dat(1,target_on(:,:,j),blocks_order == j*set_sz_dt));
    std_on(j) = nanstd(dat(1,target_on(:,:,j),blocks_order == j*set_sz_dt));
    mean_off(j) = nanmean(dat(1,target_off(:,:,j),blocks_order == j*set_sz_dt));
    std_off(j) = nanstd(dat(1,target_off(:,:,j),blocks_order == j*set_sz_dt));
end
end