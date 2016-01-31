function [ lowapproximation ] = lowapproximationofX( granulateresult,X )
%计算X的下近似
%granulateresult n*1 cell
lowapproximation=cell(1);
for i=1:length(granulateresult)
   if length(intersect(granulateresult{i},X))==length(granulateresult{i})
       lowapproximation{1}=[lowapproximation{1},i];
   end
end

end

