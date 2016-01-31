function [ flag ] = isconsistenceDataset(dataset, dataD )
%UNTITLED2 Summary of this function goes here
%   判断一个信息表是不是一致的

granulateresult = granulatedatabyequalrelation( dataset )

granulateresult= distinctcell( granulateresult );

for i=1:length(granulateresult)
   if  length(distinctcell(dataD(granulateresult{i})))>1
       flag=0; %0表示不一致
       break;
   else
       flag=1; %1表示一致
   end
end

end

