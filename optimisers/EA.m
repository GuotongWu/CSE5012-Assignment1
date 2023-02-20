% bestx: the best solution found by your algorithm
% recordedAvgY: array of  average fitnesses of each generation
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
bestSoFarFit = 0; % best-so-far fitness value
bestSoFarSolution = NaN; % best-so-far solution
%recorders
fitness_gen=[]; % record the best fitness so far
solution_gen=[];% record the best phenotype of each generation
fitness_pop=[];% record the best fitness in current population

popsize = 100;
q = 10;

pop = Initialization(popsize);
fitness = Evaluation(pop, objective);

[~,index] = max(fitness);
fitness_gen(1) = fitness(index);
solution_gen(1) = bin2dec(pop(index,:));
fitness_pop(1) = fitness(index);
nbGen = nbGen + 1;
nbEval = nbEval + popsize;

function pop = Initialization(popsize,lb,ub)
    x = lb+(ub-lb)*rand([1,popsize]);
    eta = rand([1,popsize]);
    pop = [x;eta];
end

function fitness = Evaluation(pop, objective)
    fitness = objective(pop(1,:));
end

function offspring = CreateNew(parent, n, lb, ub)
    tau1 = 1/(sqrt(2*sqrt(n)));
    tau2 = 1/sqrt(2*n);
    x = parent(1,:) + parent(2,:).*randn(1,n);
    x = boundData(x, lb, ub);
    eta = parent(2,:).*exp(tau1*randn(1,n)+tau2*randn(1,n));
    offspring = [x;eta];
end

function offspring = Comparison(pop, q)

end

function newpop = Selection(offspring)

end

end