function S = build_struct(size,cond,set_sizes)
    num_of_cond = length(cond);
    num_of_sizes = length(set_sizes);
    GenericBlock = struct("condition", "", "set_size", 0, "has_target", bool, "acc", bool,"rt", zer);
    for i = 1:size
        cur_block = char("B" + i)
        S.(cur_block) = GenericBlock;
        if i < size/2
            S.(cur_block).condition = cond(1);
        else
            S.(cur_block).condition = cond(2);
        end
        S.(cur_block).set_size = set_size(mod(num_of_cond),num_of_sizes);
    end
end