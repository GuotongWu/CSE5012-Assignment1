classdef noisyQuartic < PROBLEM
% <single> <real> <expensive/none>
% noisyQuartic function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 30; end
            obj.lower    = zeros(1,obj.D) - 1.28;
            obj.upper    = zeros(1,obj.D) + 1.28;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            idx = 1:size(PopDec,2);
            PopObj = sum(idx.*(PopDec.^4), 2) + rand;
        end
    end
end