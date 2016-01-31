function [ red ] = prreduce( dataset,dataD)
%约简算法
%思想：通过保持正域不变
%   Detailed explanation goes here

lowapproximationD = lowapproximationofD( dataset,dataD )

[n,m]=size(dataset);

red=[]; %存放约简结果
%内部重要度

for i=1:m
    tempdata=dataset;
    tempdata(:,i)=[];
    lowapproximationofDtempdata=lowapproximationofD( tempdata,dataD );
    if length(lowapproximationD{1})-length(lowapproximationofDtempdata{1})>0
       red=[red,i];
    end  
end

%外部重要度
C=[1:1:m];
B=setdiff(C,red);
lowapproximationofDred=lowapproximationofD(dataset(:,red),dataD);
templength=length(lowapproximationofDred{1});

while length(lowapproximationD{1})~=templength
    lowmaxlength=0;
    maxindex=1;
    for i=1:length(B)
        redtemp=[red B(i)];  %将B=C-red中的元素依次添加到redtemp
        lowapproximationofDmat=lowapproximationofD( dataset(:,redtemp),dataD );
        templength=length(lowapproximationofDmat{1});
        if lowmaxlength < templength
            lowmaxlength=templength;
            maxindex=i;
        end
        redtemp(length(redtemp))=[];  %将添加到redtemp中元素移除除去
    end
    red=[red,maxindex];
end

end

