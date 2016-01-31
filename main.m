function [certainRule,possibleRule] = main(data,dataD)
% 参考论文：Kryszkiewicz M. Rules in incomplete information systems[J]. Information sciences, 1999, 113(3): 271-292.

display('*******************************************************')
optimalScale = select_optimal_scale(data,dataD );
dataset=data{optimalScale};
reduceSet = discernibilityMatrix( dataset,dataD);
attrlength=size(data{1},2);

%？？？？？？？？？？？注意修改 reduceSet{1} 用的第一个约简结果？？？？？？？？？？？？？
onereduceSet=reduceSet{1};
dataset(:,setdiff([1:attrlength],onereduceSet))=[];

[ilength,jlength]=size(dataset);

lowapproximationD = lowapproximationofD( dataset,dataD );
lowapproximationD=lowapproximationD{1};
boundary=setdiff([1:ilength],lowapproximationD);

granulateresult = granulatedatabyequalrelation( dataset );

granulateresultD = granulatedatabyequalrelation( dataD );
%distinctgranulateresultD = distinctcell( granulateresultD );
%distinctgranulateresultDlength=length(distinctgranulateresultD);

certainRule={};

for d=1:length(lowapproximationD)
    i=lowapproximationD(d);
    bujicurrentdgranule=setdiff([1:ilength],granulateresultD{i});
    certainRuletemp = onediscernibilityMatrix( dataset,i,bujicurrentdgranule);
    certainRuletemplength=length(certainRuletemp);
    for k=1:certainRuletemplength
        onecertainRuletemp=certainRuletemp{k};
        onecertainRuletemplenth=length(onecertainRuletemp);
        strtemp='';
        for j=1:onecertainRuletemplenth
            if j~=onecertainRuletemplenth
                strtemp=strcat('(',int2str(onereduceSet(onecertainRuletemp(j))),',',dataset{i,onecertainRuletemp(j)},')','^');
            else
                strtemp =strcat(strtemp,'(',int2str(onereduceSet(onecertainRuletemp(j))),',',dataset{i,onecertainRuletemp(j)},')','==>',dataD{i});
            end
        end
        certainRule{length(certainRule)+1}=strtemp;
    end
end
certainRule=certainRule';
certainRule = distinctcell2( certainRule );


%possible rules

possibleRule={};

for d=1:length(boundary)
    i=boundary(d);
    bujicurrentdgranule=setdiff([1:ilength],granulateresultD{i});
    possibleRuletemp= onediscernibilityMatrix( dataset,i,bujicurrentdgranule);
    possibleRuletemplength=length(possibleRuletemp);
    for k=1:possibleRuletemplength
        onepossibleRuletemp=possibleRuletemp{k};
        onepossibleRuletemplenth=length(onepossibleRuletemp);
        strtemp='';
        for j=1:onepossibleRuletemplenth
            if j~=onepossibleRuletemplenth
                strtemp=strcat('(',int2str(onereduceSet(onepossibleRuletemp(j))),',',dataset{i,onepossibleRuletemp(j)},')','^');
            else
                strtemp =strcat(strtemp,'(',int2str(onereduceSet(onepossibleRuletemp(j))),',',dataset{i,onepossibleRuletemp(j)},')','==>',dataD{i});
            end
        end
        possibleRule{length(possibleRule)+1}=strtemp;
    end
end
possibleRule=possibleRule';
possibleRule = distinctcell2(possibleRule );

end