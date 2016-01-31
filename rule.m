function [ rule,uniquerule ] = rule( dataset,dataD )
%UNTITLED Summary of this function goes here
% ²Î¿¼ÂÛÎÄ£ºKryszkiewicz M. Rules in incomplete information systems[J]. Information sciences, 1999, 113(3): 271-292.

[ilength,jlength]=size(dataset)

granulateresult = granulatedatabyequalrelation( dataset );

granulateresultD = granulatedatabyequalrelation( dataD );
distinctgranulateresultD = distinctcell( granulateresultD );
distinctgranulateresultDlength=length(distinctgranulateresultD);

certainRule={};
possibleRule={};

for d=1:ilength
    bujicurrentdgranule=setdiff([1:ilength],granulateresultD{d});
    
    rule = onediscernibilityMatrix( data,d,bujicurrentdgranule )
    
    
end



end


end

