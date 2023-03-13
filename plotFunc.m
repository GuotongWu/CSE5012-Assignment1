clc
clear
close all
% load configuration and benchmark
configurations

numFunc=length(configuration.funcIndices);
inter = 100;

% Loop over functions
for funcIdx=configuration.funcIndices
    functionInfo=benchmark(funcIdx);
    objFunc=functionInfo.funcName{1};
    lb=functionInfo.bounds(1);
    ub=functionInfo.bounds(2);
    eval(sprintf('objective=@%s;',objFunc))
    [X,Y] = meshgrid(linspace(lb,ub,inter),linspace(lb,ub,inter));
    Z = zeros(size(X));
    for k = 1:inter
        for j = 1:inter
            Z(k,j) = objective([X(k,j),Y(k,j)]);
        end
    end
    figure
    surf(X,Y,Z);
    title(objFunc)
    xlabel('x');ylabel('y');zlabel('z');
    f = gcf;
    exportgraphics(f,"./figure/test_problem/"+num2str(funcIdx)+".png",'Resolution',300)
%     colormap spring;
end