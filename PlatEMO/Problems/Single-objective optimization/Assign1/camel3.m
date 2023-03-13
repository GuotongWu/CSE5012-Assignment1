classdef camel3 < PROBLEM
% <single> <real> <expensive/none>
% camel3 function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 2; end
            obj.lower    = zeros(1,obj.D) - 5;
            obj.upper    = zeros(1,obj.D) + 5;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj = 2*PopDec(:,1).^2 - 1.05*PopDec(:,1).^4 +...
                    PopDec(:,1).^6/6  + PopDec(:,1).*PopDec(:,2) + PopDec(:,2).^2;
        end
    end
end