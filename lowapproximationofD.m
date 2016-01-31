function [ lowapproximationD ] = lowapproximationofD( dataset,dataD )
%计算X的下近似
%dataset n*m cell 存放条件属性的数据集
%dataD n*1 cell  存放决策属性的数据集

granulateresult = granulatedatabyequalrelation( dataset );

granulateresultD = granulatedatabyequalrelation( dataD );
distinctgranulateresultD = distinctcell( granulateresultD );


lowapproximationD=cell(1);
for i=1:length(distinctgranulateresultD)
    lowapproximationD{1} = [lowapproximationD{1},cell2mat(lowapproximationofX( granulateresult,distinctgranulateresultD{i}))];
end

end

