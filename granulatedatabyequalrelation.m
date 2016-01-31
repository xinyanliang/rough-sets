function [ granulateresult ] = granulatedatabyequalrelation( dataset )
%计算不完备数据集的等价类
%   dataset:n*m的cell类型

[n,m]=size(dataset);
granulateresult=cell(n,1); %存放粒化的结果

for i=1:n
    granulateresult{i}=[i];
    for j=1:n
        if i~=j
            attrequalcount=0;
            for k=1: m
                if strcmp(dataset{i,k},dataset{j,k}) || strcmp(dataset{i,k},'*') || strcmp(dataset{j,k},'*')
                    attrequalcount=attrequalcount+1;
                end
            end
            if attrequalcount==m
                granulateresult{i}=[granulateresult{i} j];
            end
        end
    end
end
 %granulateresult=distinctcell2( granulateresult );
end

