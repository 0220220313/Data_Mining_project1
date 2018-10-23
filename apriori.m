clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%weka data%%%%%%%%%%%%%%%%%%%%%%%%%
% tic
% data=load('dataset.csv');
% T=sparse(data);   
% sup=length(T)*0.2;
% con=0.9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%IBM data%%%%%%%%%%%%%%%%%%%%%%%%%

data=load('hw1.data');
tic
T=sparse(980,100);
for i=1:(length(data))
    T(data(i,1),data(i,3)+1)=1;       
end
toc
sup=length(T(1,:))*0.05;
con=0.6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
num=0;
tmp=0;
for i=1:length(T(1,:))
    K=nnz(T(:,i));
    if(K>=sup)
        num=num+1;
        NZ{1}{num}=[i,K];
    end
end
num=0;
level=2;
for i=1:length(NZ{1})-1
    fprintf("算sup中-----目前: %d層 進度 %d / %d \n",level,i,length(NZ{level-1}));
    for j=(i+1):length(NZ{1})
        K=nnz(T(:,NZ{1}{i}(1))&T(:,NZ{1}{j}(1)));
        if(K>=sup)
            num=num+1;
            NZ{2}{num}=[NZ{1}{i}(1),NZ{1}{j}(1),K];
        end
    end
end

count=4;
while 1
    level=level+1;
    if(count<level)
        %fprintf("Done!! 最高為%d層\n",(level-1))
        break;
    end
    num=0;
    count=0;
    cou=0;
    for i=1:length(NZ{level-1})-2
        fprintf("算sup中-----目前: %d層 進度 %d / %d \n",level,i,length(NZ{level-1})-2);
        v1=NZ{level-1}{i}(1:level-1);
        if ~isequal(NZ{level-1}{i}(1:level-2),NZ{level-1}{i+1}(1:level-2))
            continue;
        end
        for j=(i+1):length(NZ{level-1})-1
             v2=NZ{level-1}{j}(1:level-1);
            if(~isequal(v1(1:level-2),v2(1:level-2)))
                break
            end
            v=union(v1,v2);  %先將兩個集合作聯集
            if(length(v)==level)
                tmp_T=T(:,v(1));
                for l=2:length(v)
                    tmp_T= tmp_T &  T(:,v(l));
                end
                K=nnz(tmp_T);
                if(K>=sup)
                    num=num+1;
                    NZ{level}{num}=[v,K];
                    count=count+1;
                end
            end
        end
    end
end
toc
tic
result=P_result(NZ,con);
toc


