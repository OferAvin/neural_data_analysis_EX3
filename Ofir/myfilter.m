function filtered_mat = myfilter(X , Max_RT)
% X - data to filter.
%Max_RT - maximum response time to filter above it.

filtered_mat =X;
N = size(filtered_mat,3);

for i = 1:N
    wrong_trials = filtered_mat(2,:,i) == 0; %Find wrong trials indexes.
    long_trials = filtered_mat(1,:,i) > Max_RT; %Find long trials indexes.
    filtered_mat(:,wrong_trials,i) = NaN; %Mark as NaN
    filtered_mat(:,long_trials,i) = NaN; %Mark as NaN
end
end