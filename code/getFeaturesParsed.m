function Trees = getFeaturesParsed(allSNum,allSKids,allSTree,We_orig,theta,params)

[W1, W2, W3, W4, b1, b2, b3, W, b, uW, ub, We] = stack2param(theta, params.decodeInfo);

num_examples = length(allSNum);

Trees = cell(num_examples,1);

for ii = 1:num_examples;
    data = allSNum{ii};
    
    words_indexed = data;
    if ~isempty(We)
        L = We(:, words_indexed);
        words_embedded = We_orig(:, words_indexed) + L;
    else
        words_embedded = We_orig(:, words_indexed);
    end
    
    % Forward Propagation
    [size1 size2] = size(words_embedded);
    
    Tree = tree2;
    Tree.pp = zeros((2*size2-1),1);
    Tree.nodeNames = 1:(2*size2-1);
    Tree.kids = zeros(2*size2-1,2);
    Tree.nodeFeatures = [words_embedded zeros(size1, size2-1)];
    
    Tree.ngrams = zeros(2*size2-1,2);
    Tree.ngrams(1:size2,1) = 1:size2;
    Tree.ngrams(1:size2,2) = 1:size2;
    
    
    strs = zeros(2*size2-1,2);
    strs(1:size2,1) = 1:size2;
    strs(1:size2,2) = 1:size2;
    
    for i = size2+1:2*size2-1
        kids = allSKids{ii}(i,:);
        
        c1 = Tree.nodeFeatures(:,kids(1));
        c2 = Tree.nodeFeatures(:,kids(2));
        
        p = params.f(W1*c1 + W2*c2 + b1);
        
        % deep layers
        for l = 1:(length(params.deepLayers)-1)
            p = params.f(W{l}*p + b{l});
        end
        
        if params.norm1
            p = p./norm(p);
        end
        
        strs(i,1) = strs(kids(1),1);
        strs(i,2) = strs(kids(2),2);
        
        Tree.nodeFeatures(:,i) = p;
        
        Tree.ngrams(i,1) = Tree.ngrams(kids(1),1);
        Tree.ngrams(i,2) = Tree.ngrams(kids(2),2);
    end
    Tree.pp = allSTree{ii};
    Tree.kids = allSKids{ii};
    Tree.nums = allSNum{ii};
    
    Trees{ii} = Tree;
end


end

