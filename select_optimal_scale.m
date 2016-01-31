function [ optimalScale ] = select_optimal_scale(data,dataD )
%data={data1 data2 ...}

%论文数据实验演示
%[ optimalScale ] = select_optimal_scale(data2,d2 ) 例1
%[ optimalScale ] = select_optimal_scale(data1,d1 ) 例2

scaleNum=length(data);
objectNum=length(data{1});

%判断多尺度数据集是否一致开始
isconsistence=0;
for i=1:scaleNum
    isconsistence=isconsistence+isconsistenceDataset(data{i}, dataD );
end
if isconsistence==0  %如果每个尺度都不一致，则不一致；否则一致
    isconsistenceflag=0; % 1表示不一致
else
    isconsistenceflag=1;
end

%判断多尺度数据集是否一致结束

if isconsistenceflag==1
    %一致的信息表按照下面的方法选择最有scale
    display('一致的信息表')
    for i=1:scaleNum
        lowapproximationD  = lowapproximationofD( data{i},dataD );
        if length(lowapproximationD{1})<objectNum
            optimalScale =(i-1);
            break;
        else
            optimalScale=0;  %出错信息
        end
    end
else
    %不一致的信息表按照下面的方法选择最有scale
    display('不一致的信息表')
    lowapproximationD  = lowapproximationofD( data{1},dataD );
    first = length(lowapproximationD{1});
    for i=2:scaleNum
        lowapproximationD  = lowapproximationofD( data{i},dataD );
        length(lowapproximationD{1});
        if length(lowapproximationD{1})==first
            optimalScale =i;
            break;
        else
            optimalScale=0;
        end
    end
end

end

