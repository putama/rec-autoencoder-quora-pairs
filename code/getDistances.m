function pl = getDistances(Trees1,Trees2,type)

num_examples = length(Trees1);
pl = cell(num_examples,1);
for i = 1:num_examples
    t1 = Trees1{i};
    t2 = Trees2{i};
       
    dist = slmetric_pw([t1.nodeFeatures], [t2.nodeFeatures], type);

    pl{i} = dist;
end