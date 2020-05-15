%this function gets two vectors , extracts two sub vectors according
%to intersect_value and returns the intersection
function [intersect_vec] = get_sub_vec_intersect(first_vec,intersect_value_1,second_vec,intersect_value_2)
    first_vec_intersect = find(first_vec == intersect_value_1);
    second_vec_intersect = find(second_vec == intersect_value_2);
    intersect_vec = intersect(first_vec_intersect,second_vec_intersect);
end