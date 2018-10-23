clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data=load('dataset.csv');
% T=sparse(data);   %weka data
% sup=length(T)*0.2;
% con=0.9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=load('hw1.data');
T=sparse(980,100);
for i=1:(length(data))
    
    T(data(i,1),data(i,3)+1)=1;
end
sup=length(T(1,:))*0.05;
con=0.6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
num=0;
tmp=0;
sort_T=0;
result={};
for i=1:length(T(1,:))
    if nnz(T(:,i))>=sup
        sort_T(i,1)=nnz(T(:,i));
    else
        sort_T(i,1)=0;
    end
    sort_T(i,2)=i;
end
sort_T=sortrows(sort_T);
SP_data={};
num=0;
num2=0;
valid_num=0;
%past=[];
for i=1:length(sort_T(:,1))
    if sort_T(i,1)~=0
        num=num+1;
        result{1}(num,1)=sort_T(i,2);
        result{1}(num,2)=sort_T(i,1);
    else
        num2=num2+1;
        valid_num=i;
        %past(num2)=sort_T(i,2);
    end
end
valid_num=valid_num+1;
for i=1:length(T(:,1))
    tmp_array=0;
    num=0;
    for j=length(sort_T):-1:valid_num
        if(T(i,sort_T(j,2))==1)                                    %排序
            num=num+1;
            tmp_array(num)=sort_T(j,2);
        end
    end
    SP_data{i,1}=tmp_array;
end
SP_T={};
search_table={};

for i=1:length(SP_data)
    if SP_data{i}~=0
        search_num=0;
        [SP_T,search_table,search_num]=SP_add(SP_data{i,1},1,SP_T,1,search_table,search_num);
    end
end
num=0;
for i=valid_num:length(sort_T)
    %fprintf("目前進度 %d / %d\n",i,length(sort_T)-valid_num+1);
    copy_array={};
    copy_array=search_array(search_table{sort_T(i,2)},SP_T);
    result=N_find_FQ(result,sort_T(:,2),copy_array,sort_T(i,2),sup);
%    result=find_FQ(result,sort_T(:,2),copy_array,sort_T(i,2),sup,past);
%     if i==1
%         past(i)=sort_T(i,2);
%     else
%         past(end+1)=sort_T(i,2);
%     end
end
toc

    ANS=FP_result(result,con,length(data));








