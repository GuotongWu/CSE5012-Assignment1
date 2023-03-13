classdef michal < PROBLEM
% <single> <real> <expensive/none>
% michal function

    methods
        %% Default settings of the problem
        function Setting(obj)
            obj.M = 1;
            if isempty(obj.D); obj.D = 2; end
            obj.lower    = zeros(1,obj.D) - 0;
            obj.upper    = zeros(1,obj.D) + pi;
            obj.encoding = ones(1,obj.D);
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            m = 10;
            sum = 0;
            for ii = 1:obj.D
                xi = PopDec(:,ii);
                new = sin(xi) .* sin(ii*xi.^2/pi).^(2*m);
                sum  = sum + new;
            end
            PopObj = -sum;
        end
    end
end