clc
clear
close all
% load configuration and benchmark
configurations

numFunc=length(configuration.funcIndices);
numLoop = 8;
rng(1);

% Loop over functions
funcIdx = 2;
functionInfo=benchmark(funcIdx);
objFunc=functionInfo.funcName{1};
n=functionInfo.dimension;
lb=functionInfo.bounds(1);
ub=functionInfo.bounds(2);
nbEvaluation=configuration.budget(funcIdx);

recordedBestY1 = zeros(numLoop, nbEvaluation/100);
recordedBestY2 = zeros(numLoop, nbEvaluation/100);
recordedBestY3 = zeros(numLoop, 1501);
recordedBestY4 = zeros(numLoop, 1501);

parfor r = 1:numLoop
    [~, ~, recordedBestY1(r,:)] = EA(objFunc,n,lb,ub,nbEvaluation,"FEP");
    [~, ~, recordedBestY2(r,:)] = EA(objFunc,n,lb,ub,nbEvaluation,"CEP");
    [~, ~, recordedBestY3(r,:)] = EA(objFunc,n,lb,ub,nbEvaluation,"LFEP");
    [~, ~, recordedBestY4(r,:)] = EA(objFunc,n,lb,ub,nbEvaluation,"LFEP-AL");
end
    
meanBest1 = mean(recordedBestY1, 1);
meanBest2 = mean(recordedBestY2, 1);
meanBest3 = mean(recordedBestY3, 1);
meanBest4 = mean(recordedBestY4, 1);

semilogy(meanBest1)
hold on
semilogy(meanBest2)
semilogy(meanBest3)
semilogy(meanBest4)
legend(["FEP","CEP","LFEP","LFEP-AL"])