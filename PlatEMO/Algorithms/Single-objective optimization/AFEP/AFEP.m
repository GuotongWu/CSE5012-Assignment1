classdef AFEP < ALGORITHM
% <single> <real/integer> <large/none> <constrained/none>
% Adaptive fast evolutionary programming

%------------------------------- Reference --------------------------------
% X. Yao, Y. Liu, and G. Lin, Evolutionary programming made faster, IEEE
% Transactions on Evolutionary Computation, 1999, 3(2): 82-102.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2023 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        function main(Algorithm,Problem)
            %% Generate random population
            PopulationG = Problem.Initialization();
            PopulationC = Problem.Initialization();
            Population = [PopulationG, PopulationC];
            
            %% Optimization
            while Algorithm.NotTerminated(Population)
                PopulationG = Population(1:end/2);
                PopulationC = Population(end/2+1:end);
                OffspringG  = OperatorAFEP(Problem,PopulationG, "G");
                OffspringC = OperatorAFEP(Problem,PopulationC, "C");

                Population1 = [PopulationG,OffspringG,OffspringC];
                Fit = FitnessSingle(Population1);
                Population1 = TourSelect(Population1, Fit, Problem.N/2);
    
                Population2 = [PopulationC,OffspringC,OffspringG];
                Fit = FitnessSingle(Population2);
                Population2 = TourSelect(Population2, Fit, Problem.N/2);
                Population = [Population1, Population2];
            end
        end
    end
end

function Offspring = TourSelect(Population, Fit, N)
    for i = 1 : length(Population)
        Win(i) = sum(Fit(i)<=Fit(randperm(end,10)));
    end
    [~,rank]   = sort(Win,'descend');
    Offspring = Population(rank(1:N));
end

function Offspring = OperatorAFEP(Problem,Population,type)
    %% Parameter setting
    PopulationDec = Population.decs;
    [N,D]         = size(PopulationDec);

    %% initialize eta and lb
    lambda = 0.8/sqrt(D);
    initial_eta = lambda * rand(N,D) .* repmat((Problem.upper-Problem.lower),N,1);
    initial_lb = mean(initial_eta,2);
    eta_lb = Population.adds([initial_eta,initial_lb]);
    PopulationEta = eta_lb(:,1:D);
    lb = eta_lb(:,end);
    tau  = 1/sqrt(2*sqrt(D));
    tau1 = 1/sqrt(2*D);
    
    %% Fast evolutionary programming
    if strcmp(type, "C")
        OffDec = PopulationDec + PopulationEta.*trnd(1,N,D);
    else
        OffDec = PopulationDec + PopulationEta.*randn(N,D);
    end
    OffEta       = PopulationEta.*exp(tau1*repmat(randn(N,1),1,D)+tau*randn(N,D));
    lb           = lb .* exp(randn(N,1));
    OffEta       = boundData(OffEta,lb);
    Offspring    = Problem.Evaluation(OffDec,[OffEta,lb]);
end