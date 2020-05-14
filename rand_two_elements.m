%this function gets a two elements vector and randomly returns one of them as first and second
function[first_element,second_element] = rand_two_elements(elements_vector)
	check = rand(1,1);
	if check>0.5
		first_element = elements_vector(1);
		second_element = elements_vector(2);
	else
		first_element = elements_vector(2);
	   second_element = elements_vector(1);
	end
end