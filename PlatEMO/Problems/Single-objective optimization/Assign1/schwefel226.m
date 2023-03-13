classdef schwefel226 < PROBLEM
% <single> <real> <expensive/none>
% schwefel226 function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 30; end
            obj.lower    = zeros(1,obj.D) - 500;
            obj.upper    = zeros(1,obj.D) + 500;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            absx = abs(PopDec);
            PopObj = -sum(PopDec.*sin(sqrt(absx)), 2);
        end
    end
end