classdef CEP < ALGORITHM
% <single> <real/integer> <large/none> <constrained/none>
% Imporoved fast evolutionary programming

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
            Population = Problem.Initialization();
            
            %% Optimization
            while Algorithm.NotTerminated(Population)
                Offspring  = OperatorCEP(Problem,Population);
                Population = [Population,Offspring];
                Fit = FitnessSingle(Population);
                Win = zeros(1,length(Population));
                for i = 1 : length(Population)
                    Win(i) = sum(Fit(i)<=Fit(randperm(end,10)));
                end
                [~,rank]   = sort(Win,'descend');
                Population = Population(rank(1:Problem.N));
            end
        end
    end
end


function Offspring = OperatorCEP(Problem,Population)
    %% Parameter setting
    PopulationDec = Population.decs;
    [N,D]         = size(PopulationDec);
    PopulationEta = Population.adds(rand(N,D));
    
    %% Fast evolutionary programming
    tau  = 1/sqrt(2*sqrt(D));
    tau1 = 1/sqrt(2*D);
    OffDec       = PopulationDec + PopulationEta.*randn(N,D);
    OffEta       = PopulationEta.*exp(tau1*repmat(randn(N,1),1,D)+tau*randn(N,D));
%     mean(OffEta, "all")
    OffEta       = boundData(OffEta,1e-3);
    Offspring    = Problem.Evaluation(OffDec,OffEta);
end