function[x_vec,y_vec] = rand_location(num_of_element)
x_vec = randperm(100,num_of_element).*0.01;
y_vec = randperm(100,num_of_element).*0.01;
