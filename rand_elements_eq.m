function a = rand_elements_eq(num, elements)
    a = mod(randperm(num),length(elements));
end