function a = rand_num_of_elements_eq(length, num_of_elements)
    a = mod(randperm(length),num_of_elements);
end