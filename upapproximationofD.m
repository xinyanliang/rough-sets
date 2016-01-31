function [ upapproximationD ] = upapproximationofD( dataset,dataD )
%计算X的下近似
%dataset n*m cell 存放条件属性的数据集
%dataD n*1 cell  存放决策属性的数据集

granulateresult = granulatedatabyequalrelation( dataset );

granulateresultD = granulatedatabyequalrelation( dataD );
distinctgranulateresultD = distinctcell( granulateresultD );


upapproximationD=cell(1);
for i=1:length(distinctgranulateresultD)
    upapproximationD{1} = [upapproximationD{1},cell2mat(upapproximationofX( granulateresult,distinctgranulateresultD{i}))];
end

end

