%作者：梁新彦
function [rule] = onediscernibilityMatrix( data,d,bujicurrentdgranule )
%通过差分矩阵求取约简
% data(n,m):cell  条件属性信息表
%d:int      当前处理的对象下标
%bujicurrentdgranule 决策属性生成的等价类，当前元素等价类的补集


[ilength,jlength]=size(data);

bujicurrentdgranulelength=length(bujicurrentdgranule);
DM=cell(bujicurrentdgranulelength,1);

%计算差分矩阵

for i=1:bujicurrentdgranulelength
    attr=[];
    for k=1:jlength
        if ~(strcmp(data{bujicurrentdgranule(i),k},data{d,k})|| strcmp(data{bujicurrentdgranule(i),k},'*') || strcmp(data{d,k},'*'))
            attr=[attr,k];
        end
    end
    DM{i}=attr;
end
DMtemp=distinctcell( DM );
%计算差分矩阵结束

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
    resultCell{i}=unique(resultCell{i});
    resultCell{i}= sort(resultCell{i});
end

%如果a&b&c | a&b 同时存在，去掉 a&b&c
i=1;
while i<=length(resultCell)
    j=1;
    while j<=length(resultCell)
        if i~=j
            if length(intersect(resultCell{i},resultCell{j}))==length(resultCell{i})
                resultCell(j)=[];
            elseif length(intersect(resultCell{i},resultCell{j}))==length(resultCell{j})
                resultCell(i)=[];
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

%如果a&b&c | a&b 同时存在，去掉 a&b

rule=resultCell;

end

