classdef holder < PROBLEM
% <single> <real> <expensive/none>
% holder function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 2; end
            obj.lower    = zeros(1,obj.D) - 10;
            obj.upper    = zeros(1,obj.D) + 10;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            x1 = PopDec(:,1);
            x2 = PopDec(:,2);
            fact1 = sin(x1).*cos(x2);
            fact2 = exp(abs(1 - sqrt(x1.^2+x2.^2)/pi));
            PopObj = -abs(fact1.*fact2);
        end
    end
end