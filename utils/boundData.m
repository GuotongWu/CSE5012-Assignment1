function [newData]=boundData(data,lb,ub)
newData=data;

indices=find(data<lb);
if size(lb,2) ~= 1
    lb = repmat(lb, size(newData,1), 1);
    newData(indices) = lb(indices);
else
    newData(indices) = lb;
end
if nargin == 3
    indices=find(data>ub);
    newData(indices)=ub;
end
end