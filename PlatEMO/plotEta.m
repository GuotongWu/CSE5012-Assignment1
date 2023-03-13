filePath = "./Data/CEP/CEP_ackley_M1_D30_31.mat";
load(filePath, "result")
etaVal = zeros(1, length(result));
for i = 1:length(result)
    etaVal(i) = mean(cat(1,result{i,2}.add), "all");
end
plot(100:100:100000, etaVal(1:1000), LineWidth=1.2)
xlabel("Evaluation Number")
ylabel("\eta")