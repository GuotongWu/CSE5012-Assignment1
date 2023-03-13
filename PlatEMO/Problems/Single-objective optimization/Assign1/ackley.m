classdef ackley < PROBLEM
% <single> <real> <expensive/none>
% ackley function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 30; end
            obj.lower    = zeros(1,obj.D) - 32;
            obj.upper    = zeros(1,obj.D) + 32;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj = -20*exp(-0.2*sqrt(sum(PopDec.^2,2)/obj.D))...
                -exp(sum(cos(2*pi*PopDec),2)/obj.D) + 20 + exp(1);
        end
    end
end