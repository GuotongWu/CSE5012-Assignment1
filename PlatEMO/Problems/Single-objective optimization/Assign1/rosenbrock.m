classdef rosenbrock < PROBLEM
% <single> <real> <expensive/none>
% Generalized Rosenbrock's function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 30; end
            obj.lower    = zeros(1,obj.D) - 30;
            obj.upper    = zeros(1,obj.D) + 30;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj = sum(100*(PopDec(:,2:end)-PopDec(:,1:end-1).^2).^2+(PopDec(:,1:end-1)-1).^2,2);
        end
    end
end