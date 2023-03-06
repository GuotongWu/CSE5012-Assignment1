% bestx: the best solution found by your algorithm
% recordedAvgY: array of average fitnesses of each generation
% recordedBestY: array of best fitnesses of each generation
function [bestx, recordedAvgY, recordedBestY]=EA(funcName,n,lb,ub,nbEvaluation)
warning on MATLAB:divideByZero
if nargin < 5
  error('input_example :  not enough input')
end

eval(sprintf('objective=@%s;',funcName)); % Do not delete this line
% objective() is the evaluation function, for example : fitness = objective(x) 

%% Your algorithm

%% Initialization
nbGen = 0; % generation counter
nbEval = 0; % evaluation counter
popsize = 100;
q = 10;
%recorders
recordedAvgY = zeros(1, nbEvaluation/popsize); 
recordedBestY = zeros(1, nbEvaluation/popsize);

pop = Initialization(popsize, lb, ub, n);
fitness = Evaluation(pop, objective, n);

recordedAvgY(1) = mean(fitness);
[recordedBestY(1),best_index] = min(fitness);
bestx = pop(best_index,1:n);
nbGen = nbGen + 1;
nbEval = nbEval + popsize;

while nbEval < nbEvaluation
    newpop = CreateNew(pop, lb, ub, "FEP");

    new_fitness = Evaluation(newpop, objective, n);
    nbEval = nbEval + popsize;
    nbGen = nbGen + 1;
    
    temp_pop = [pop;newpop];
    recordedAvgY(nbGen) = mean([fitness,new_fitness]);
    [bestY, best_index] = min([fitness,new_fitness]);
    if bestY < recordedBestY(nbGen-1)
        recordedBestY(nbGen) = bestY;
        bestx = temp_pop(best_index,1:n);
    else
        recordedBestY(nbGen) = recordedBestY(nbGen-1);
    end

    offspring = Selection([pop;newpop], q, popsize, [fitness,new_fitness]);
    pop = offspring;
    fitness = new_fitness;
    
end


end

function pop = Initialization(popsize,lb,ub,n)
    x = lb+(ub-lb)*rand([popsize,n]);
    eta = 3*ones([popsize,n]); % 初始值为3
    pop = [x, eta];
end

function fitness = Evaluation(pop, objective, n)
    popsize = size(pop,1);
    fitness = zeros(1,popsize);
    for k = 1:popsize
        fitness(k) = objective(pop(k,1:n));
    end
end

function newpop = CreateNew(parent, lb, ub, type)
    popsize = size(parent,1);
    n = size(parent,2)/2;
    tau1 = 1/(sqrt(2*sqrt(n)));
    tau2 = 1/sqrt(2*n);
    GaussianRand  = repmat(randn(popsize,1),1,n);
    GaussianRandj = randn(popsize,n);
    if strcmp(type, "CEP")
        x = parent(:,1:n) + parent(:,n+1:end).*rand(popsize,n);
    else
        x = parent(:,1:n) + parent(:,n+1:end).*trnd(1, popsize,n);
    end
    x = boundData(x, lb, ub);
    eta = parent(:,n+1).*exp(tau1*GaussianRand+tau2*GaussianRandj);
    newpop = [x, eta];
end

% function child = CreateNew(parent, n, lb, ub)
%     tau1 = 1/(sqrt(2*sqrt(n)));
%     tau2 = 1/sqrt(2*n);
%     x = parent(1:n) + parent(n+1:end).*randn(1,n);
%     x = boundData(x, lb, ub);
%     normrand = randn;
%     eta = parent(n+1:end).*exp(tau2*normrand+tau1*randn(1,n));
%     child = [x,eta];
% end

function newpop = Selection(pop, q, mu, fitness)
    popsize = size(pop,1);
    wins = zeros(1, popsize);
    for k = 1:popsize
        opponents = randperm(popsize,q);
        wins(k) = sum(fitness(k)<=fitness(opponents)); % 最小化问题
    end
    [~, index] = sort(wins, 'descend');
    newpop = pop(index(1:mu),:);
end