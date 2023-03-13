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
    [bestx, recordedAvgY, recordedBestY] = EP(objective,n,lb,ub,nbEvaluation,"LFEP");
end

function fitness = Evaluation(x, objective)
    popsize = size(x,1);
    fitness = zeros(1,popsize);
    for k = 1:popsize
        fitness(k) = objective(x(k,:));
    end
end

function SelectIndex = tournamentSelec(q, mu, fitness)
    popsize = length(fitness);
    wins = zeros(1, popsize);
    for k = 1:popsize
        opponents = randperm(popsize,q);
        wins(k) = sum(fitness(k)<=fitness(opponents)); % 最小化问题
    end
    [~, index] = sort(wins, 'descend');
    SelectIndex = index(1:mu);
end

function [bestx, recordedAvgY, recordedBestY] = EP(objective,n,lb,ub,nbEvaluation,type)
    nbGen = 1; % generation counter
    nbEval = 0; % evaluation counter
    popsize = 100;
    q = 10;

    %recorders
    recordedAvgY = []; 
    recordedBestY = [];
    
    pop = lb+(ub-lb)*rand([popsize,n]);
    eta = 3*ones([popsize,n]);
    fitness = Evaluation(pop, objective);
    
    recordedAvgY(1) = mean(fitness);
    [recordedBestY(1),best_index] = min(fitness);
    bestx = pop(best_index,:);
    nbEval = nbEval + popsize;
    
    tau1 = 1/(sqrt(2*sqrt(n)));
    tau2 = 1/sqrt(2*n);

    while nbEval < nbEvaluation
        GaussianRand  = repmat(randn(popsize,1),1,n);
        GaussianRandj = randn(popsize,n);
        if strcmp(type, "CEP")
            newpop = pop + eta.*randn(popsize,n);
        elseif strcmp(type, "FEP")
            newpop = pop + eta.*cauchy(popsize,n);
%         elseif strcmp(type, "LFEP")
        else
            newpop = [pop + eta.*randn(popsize,n);pop + eta.*cauchy(popsize,n)];
        end
        newpop = boundData(newpop, lb, ub);
        neweta = eta.*exp(tau1*GaussianRand+tau2*GaussianRandj);
        if strcmp(type, "LFEP")
            neweta = [neweta; eta.*exp(tau1*repmat(randn(popsize,1),1,n)+tau2*randn(popsize,n))];
        end
        neweta = boundData(neweta, 0.3e-3);
        if strcmp(type, "LFEP-AL")
            neweta = [neweta; eta.*exp(tau1*repmat(randn(popsize,1),1,n)+tau2*randn(popsize,n))];
            lowerbd = min(neweta,[],1) + (max(neweta,[],1) - min(neweta,[],1))*0.5;
            neweta = boundData(neweta, lowerbd);
        end
    
        new_fitness = Evaluation(newpop, objective);
        nbEval = nbEval + size(newpop,1);
        nbGen = nbGen + 1;      
        temp_pop = [pop;newpop];
        temp_eta = [eta;neweta];
        temp_fitness = [fitness,new_fitness];
        recordedAvgY = [recordedAvgY, mean(temp_fitness)];
        [bestY, best_index] = min(temp_fitness);
        if bestY < recordedBestY(nbGen-1)
            recordedBestY = [recordedBestY, bestY];
            bestx = temp_pop(best_index,:);
        else
            recordedBestY = [recordedBestY, recordedBestY(nbGen-1)];
        end
    
        selectIndex = tournamentSelec(q, popsize, temp_fitness);
        pop = temp_pop(selectIndex,:);
        eta = temp_eta(selectIndex,:);
        fitness = temp_fitness(selectIndex);        
    end
end

function [bestx, recordedAvgY, recordedBestY] = GA(objective,n,lb,ub,nbEvaluation)
    nbGen = 1; % generation counter
    nbEval = 0; % evaluation counter
    popsize = 100;
    q = 10;
    proC = 1; % corssover probability
    disC = 20; % distriution index of simulated binary crossover
    proM = 1; % Expectation of the number of mutated variables
    disM = 20; % Distribution index of polynomial mutation


    %recorders
    recordedAvgY = []; 
    recordedBestY = [];
    
    pop = lb+(ub-lb)*rand([popsize,n]);

    while nbEval < nbEvaluation
        pop = tournamentSelec(q, mu, fitness);
        parent1 = pop(1:floor(end/2),:);
        parent2 = pop(floor(end/2)+1:floor(end/2)*2,:);
        [N,D]   = size(parent1);
    
        % Simulated binary crossover
        beta = zeros(N,D);
        mu   = rand(N,D);
        beta(mu<=0.5) = (2*mu(mu<=0.5)).^(1/(disC+1));
        beta(mu>0.5)  = (2-2*mu(mu>0.5)).^(-1/(disC+1));
        beta = beta.*(-1).^randi([0,1],N,D);
        beta(rand(N,D)<0.5) = 1;
        beta(repmat(rand(N,1)>proC,1,D)) = 1;
        newpop = [(parent1+parent2)/2+beta.*(parent1-parent2)/2
                     (parent1+parent2)/2-beta.*(parent1-parent2)/2];
        % Polynomial mutation
        lower = repmat(Problem.lower,2*N,1);
        upper = repmat(Problem.upper,2*N,1);
        Site  = rand(2*N,D) < proM/D;
        mu    = rand(2*N,D);
        temp  = Site & mu<=0.5;
        newpop = min(max(newpop,lower),upper);
        newpop(temp) = newpop(temp)+(upper(temp)-lower(temp)).*((2.*mu(temp)+(1-2.*mu(temp)).*...
                          (1-(newpop(temp)-lower(temp))./(upper(temp)-lower(temp))).^(disM+1)).^(1/(disM+1))-1);
        temp = Site & mu>0.5; 
        newpop(temp) = newpop(temp)+(upper(temp)-lower(temp)).*(1-(2.*(1-mu(temp))+2.*(mu(temp)-0.5).*...
                          (1-(upper(temp)-newpop(temp))./(upper(temp)-lower(temp))).^(disM+1)).^(1/(disM+1)));
        pop = [pop, newpop];
        [~,rank] = sort
    end

end

