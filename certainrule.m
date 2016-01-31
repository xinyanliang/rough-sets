function [ rule,uniquerule ] = certainrule( dataset,dataD )
%UNTITLED Summary of this function goes here
%   提取确定性规则

[ilength,jlength]=size(dataset)

granulateresult = granulatedatabyequalrelation( dataset );

granulateresultD = granulatedatabyequalrelation( dataD );
distinctgranulateresultD = distinctcell( granulateresultD );
distinctgranulateresultDlength=length(distinctgranulateresultD);


certainRule={}; W
for i=1:distinctgranulateresultDlength
    lowapproximation=cell2mat(lowapproximationofX( granulateresult,distinctgranulateresultD{i}));
    upapproximation=cell2mat(upapproximationofX( granulateresult,distinctgranulateresultD{i}));    
    lowapproximationlength=length(lowapproximation);
    for j=1:lowapproximationlength
        currentpos=size(certainRule,1)+1;
        for attr=1:jlength
            certainRule{currentpos,attr}=dataset{lowapproximation(j),attr};
        end
        certainRule{currentpos,jlength+1}=dataD{lowapproximation(j)};
    end
end

certainRule=certainRule';
[uniquerule ] = distinctcell2( certainRule )

end

