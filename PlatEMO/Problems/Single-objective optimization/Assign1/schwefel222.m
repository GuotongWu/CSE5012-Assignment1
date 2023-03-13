classdef schwefel222 < PROBLEM
% <single> <real> <expensive/none>
% schwefel222 function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 30; end
            obj.lower    = zeros(1,obj.D) - 10;
            obj.upper    = zeros(1,obj.D) + 10;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            absx = abs(PopDec);
            PopObj = sum(PopDec,2) + prod(absx,2);
        end
    end
end