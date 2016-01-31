function [ result ] = distinctcell2( datacell )
% ШЅжи
%distinctcell2={{};{}}
%
if length(datacell)~=0
    result(1,:)=datacell(1,:);
    for i=1:length(datacell)
        if length(datacell{i})~=0
            flag=0;
            for j=1:length(result)
                if length(find(strcmp(datacell(i,:),result(j,:))==0))>0
                    flag=flag+1;
                end
            end
            if flag==size(result,1)
                result(size(result,1)+1,:)=datacell(i,:);
            end
            
        end
    end
else
    result={};
end

end

