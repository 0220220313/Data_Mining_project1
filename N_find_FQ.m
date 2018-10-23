function result=N_find_FQ(result,table,array,itemset,sup)
flag=0;
index(1:length(table))=0;
if ~isempty (array)
    for i=1:length(array(:,1))
        count=array{i,2};
        for j=1:length(array{i,1})
            index(array{i,1}(j))=index(array{i,1}(j))+count;
        end
    end% 算次數
    valid=[];
    num=0;
    index(itemset(end))=0;
    for i=1:length(table)
        if index(table(i))>=sup
            flag=1;
            num=num+1;
            valid(num)=table(i);
            if isempty(result)||length(result)<length(itemset)+1
                result{length(itemset)+1,1}=itemset;
                result{length(itemset)+1,1}(1,end+1)=table(i);
                result{length(itemset)+1,1}(1,end+1)=index(table(i));
            else
                result{length(itemset)+1,1}(end+1,1)=itemset(1);
                if(length(itemset)>=2)
                    for j=2:length(itemset)
                        result{length(itemset)+1,1}(end,j)=itemset(j);
                    end
                end
                result{length(itemset)+1,1}(end,length(itemset)+1)=table(i);
                result{length(itemset)+1,1}(end,length(itemset)+2)=index(table(i));
            end
        end
    end %將小於sup的挑出來，大於的加入frequence set
    if flag==1
        SP_T={};
        search_table={};
        for i=1:length(array(:,1))
            if ~isempty(array{i,1})
                search_num=0;
                [SP_T,search_table,search_num]=SP_add(array{i,1},array{i,2},SP_T,1,search_table,search_num);
            end
        end
        for i=1:length(valid)
            tmp_itemset=itemset;
            tmp_itemset(end+1)=valid(i);
            copy_array={};
            copy_array=search_array(search_table{valid(i)},SP_T);
            result=N_find_FQ(result,table,copy_array,tmp_itemset,sup);
        end
    end
end
end


