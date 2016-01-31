%作者：梁新彦
function [reduceSet,DM,DMtemp] = discernibilityMatrix( data,d )
%通过差分矩阵求取约简
% data(n,m):cell  条件属性信息表
%d(n,1):cell      决策属性
%reduceSet(k,1) 每个元素为一个约简


[ilength,jlength]=size(data)
DM=cell(ilength,ilength);

%计算差分矩阵
for i=1:ilength
    for j=i:ilength
        attr=[];
        if ~strcmp(d{i},d{j})
            for k=1:jlength
                if ~(strcmp(data{i,k},data{j,k})|| strcmp(data{i,k},'*') || strcmp(data{j,k},'*'))
                    attr=[attr,k];
                end
            end
            DM{i,j}=attr;
            % DM{j,i}=attr;  %要计算下半部分矩阵就将其打开
        end
    end
end
%计算差分矩阵结束

%将DM(ilength,ilength)变换成 DMtemp{count}行，方便去重
DMtemp={};
count=0;
for i=1:ilength
    for j=i+1:ilength
        if length(DM{i,j}~=0)
            count=count+1;
            DMtemp{count}=DM{i,j};
        end
    end
end
DMtemp=DMtemp';
DMtemp=distinctcell( DMtemp );
%结束

%如果a || b || c 与a || b 同时存在，去掉 a || b || c
i=1;
while i<=length(DMtemp)
    j=1;
    while j<=length(DMtemp)
        if i~=j
            if length(intersect(DMtemp{i},DMtemp{j}))==length(DMtemp{i})
                DMtemp(j)=[];
            elseif length(intersect(DMtemp{i},DMtemp{j}))==length(DMtemp{j})
                DMtemp(i)=[];
                break;
            else
                j=j+1;
            end
        else
            j=j+1;
        end
    end
    i=i+1; 
end
%如果a || b || c 与a || b 同时存在，去掉 a || b || c 结束

count=0;
for i=1:length(DMtemp)
    count=count*length(DMtemp{i});
end

resultCell=cell(count,1);

%将每个cell元素取一个进行组合
k=0;
command='';
str='';
strend='';
for i=1:length(DMtemp)
    str=strcat(str,'j',int2str(i),',');
    strend=strcat(strend,10,'end');
    if i< length(DMtemp)
        command=strcat(command,'for j',int2str(i),'=',mat2str(DMtemp{i}),10);
    else
        command=strcat(command,10,'for j',int2str(i),'=',mat2str(DMtemp{i}),10,'k=k+1',10,'resultCell{k}=[',str,']',strend)
        eval(command);  %eval函数可以将一个字符串当代码执行
    end
end

for i=1:length(resultCell)
    resultCell{i}= sort(resultCell{i});
end
 reduceSet=resultCell;

end

