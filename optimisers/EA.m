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

pop = Initialization(popsize);
fitness = Evaluation(pop, objective);

[~,index] = max(fitness);
fitness_gen(1) = fitness(index);
solution_gen(1) = bin2dec(pop(index,:));
fitness_pop(1) = fitness(index);
nbGen = nbGen + 1;
nbEval = nbEval + popsize;

function pop = Initialization(popsize)

end

function fitness = Evaluation(pop, objective)

end

function offspring = Crossover(parent1, parent2)

end

function offspring = Mutation(offspring)

end

function newpop = Selection(offspring)

end

end