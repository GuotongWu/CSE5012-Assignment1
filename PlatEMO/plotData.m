clc,clear,close all
ProblemName = ["ackley", "camel3", "holder", "rosenbrock", "schwefel222", "schwefel226", "sphere", "michal", "noisyQuartic", "step"];
AlgorithmName = ["CEP", "FEP", "IFEP", "AFEP"];

for prob = ProblemName
    pathName = "./Data/Compare/" + prob + ".mat";
    load(pathName, "objVal")
    figure 
    hold on
    for k=1:4
        plot(100:100:500, objVal(k,1:5),LineWidth=1.2)
    end 
    hold off
    leg = legend(AlgorithmName);
    set(leg, 'Location', 'northeast')
    xlabel('Evaluation Number') 
    ylabel('Objective Value')
    title(prob)
    f = gcf;
    exportgraphics(f,"./figure/initial/"+prob+".png",'Resolution',300)
end


function archieveObjVal(ProblemName, AlgorithmName)
    for prob_k = 1:length(ProblemName)
        prob = ProblemName(prob_k);
        objVal = zeros(4, 3000);
        figure 
        hold on
        for alg_k = 1:length(AlgorithmName)
            alg = AlgorithmName(alg_k);
            for k = 1:30
                if strcmp(prob, "holder") || strcmp(prob, "michal") || strcmp(prob, "camel3")
                    pathName = "./Data/" + alg + "/" + alg + "_" + prob + "_M1_D2_" + num2str(k) + ".mat";
                else
                    pathName = "./Data/" + alg + "/" + alg + "_" + prob + "_M1_D30_" + num2str(k) + ".mat";
                end
                load(pathName, "result")
                for i = 1:length(result)
                    objVal(alg_k, i) = objVal(alg_k, i) + min(cat(1, result{i,2}.obj));
                end
            end
            plot(1:100:150000, objVal(alg_k, 1:1500)/30, 'LineWidth', 2)
        end
        objVal = objVal/30;
        save("./Data/Compare/" + prob + ".mat", "objVal")
        hold off
        leg = legend(AlgorithmName);
        set(leg, 'Location', 'northeast')
        xlabel('Evaluation Number') 
        ylabel('Objective Value')
        title(prob)
        f = gcf;
        exportgraphics(f,"./figure/performance/"+prob+".png",'Resolution',300)
    end
end