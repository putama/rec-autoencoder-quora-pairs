function [Trees1 Trees2 Trees3 Trees4] = getInstancesParsed(allSNum,allSKids,allSTree,allSNum2,allSKids2,allSTree2,theta,We2,params)

% get TRAIN features
num_examples = length(allSNum);

Trees1= getFeaturesParsed(allSNum([1:num_examples/2]*2-1),allSKids([1:num_examples/2]*2-1),allSTree([1:num_examples/2]*2-1),We2,theta,params);
Trees2= getFeaturesParsed(allSNum([1:num_examples/2]*2),allSKids([1:num_examples/2]*2),allSTree([1:num_examples/2]*2),We2,theta,params);


% Get TEST features

num_examples = length(allSNum2);

Trees3 = getFeaturesParsed(allSNum2([1:num_examples/2]*2-1),allSKids2([1:num_examples/2]*2-1),allSTree2([1:num_examples/2]*2-1),We2,theta,params);
Trees4 = getFeaturesParsed(allSNum2([1:num_examples/2]*2),allSKids2([1:num_examples/2]*2),allSTree2([1:num_examples/2]*2),We2,theta,params);


end