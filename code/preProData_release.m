function [outData,preProNorm]= preProData_release(data,params,preProNorm)

numSamples = length(data.M);
labels = data.label;

% ---------------------------
% Other Feat

X = zeros(params.sizeM*params.sizeM,numSamples);


otherFeat = zeros(4,numSamples);

for i=1:numSamples

   imgBig = data.M{i};   

   ind1 = data.freq1{i}(1:(end+1)/2) < params.cutoff;
   ind2 = data.freq2{i}(1:(end+1)/2) < params.cutoff;
   
   temp=data.M{i}(ind1,ind2);
   mindist1 = min(temp,[],1);
   mindist2 = min(temp,[],2);
   mindist1(mindist1 > 0) = 2;
   mindist2(mindist2 > 0) = 2;
   otherFeat(1:2,i) = [mean(mindist1); mean(mindist2)];
   
   ind1 = data.freq1{i}((end+1)/2+1:end) < params.cutoff;
   ind2 = data.freq2{i}((end+1)/2+1:end) < params.cutoff;
   if ~isempty(find(ind1==0,1)) || ~isempty(find(ind2==0,1))
       ind1
   end
   
   temp=data.M{i}((end+1)/2+1:end,(end+1)/2+1:end);
   temp = temp(ind1,ind2);
   mindist3 = min(temp,[],1);
   mindist4 = min(temp,[],2);
   
   mindist3(mindist3 > 0) = 2;
   mindist4(mindist4 > 0) = 2;
   otherFeat(3:4,i) = [mean(mindist3); mean(mindist4)];

   
   oneMsmall = mypool(imgBig,params.sizeM,params.pool);
   X(:,i) = oneMsmall(:);
end


otherFeat = [data.ldiff; otherFeat];


if nargin==2
   preProNorm.singleFeatMean = mean(otherFeat,2);
end
otherFeat=bsxfun(@minus,otherFeat,preProNorm.singleFeatMean);
if nargin==2
   preProNorm.singleFeatStd = std(otherFeat,0,2);
end
otherFeat=bsxfun(@rdivide,otherFeat,preProNorm.singleFeatStd);


otherFeat = [data.numeq; data.numeq2; data.numeq3; otherFeat ];

if nargin==2
   preProNorm.dataMean = mean(X(:));
end


X = X-preProNorm.dataMean;

if nargin==2
    preProNorm.pstd = 3 * std(X(:));
end

X = max(min(X,preProNorm.pstd), -preProNorm.pstd) / preProNorm.pstd;
X = (X + 1) * 0.4 + 0.1;% Rescale from [-1,1] to [0.1,0.9]


outData.X = X;
outData.labels = labels;
outData.otherFeat = otherFeat;
