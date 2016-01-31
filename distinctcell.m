function [ result ] = distinctcell( datacell )
% ШЅжи
%datacell={[1 2];[4 5]}
%
result={};

for i=1:length(datacell)
    if length(datacell{i})~=0
        flag=0;
        for j=1: length(result)
            if length(datacell{i})~=length(result{j})
                flag=flag+1;
            elseif length(find(ismember(datacell{i},result{j})==0))>0
                flag=flag+1;
            end
        end
        if flag==length(result)
            result{length(result)+1}=datacell{i};
        end
    end
end

result=result';

end

