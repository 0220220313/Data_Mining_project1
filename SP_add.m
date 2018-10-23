function [tree,search_table,search_num]=SP_add(ele,ele_num,tree,flag,search_table,search_num)
add_ele=ele(1);
if isempty(tree)
    tree{1,1}=add_ele;
    tree{1,2}=ele_num;
    if flag==1
        search_num(1)=1;
        search_table{add_ele,1}{1,1}=1;
    else
        search_num(end+1)=1;
        if add_ele>length(search_table)
            search_table{add_ele,1}{1,1}=search_num;
        else
            search_table{add_ele,1}{end+1,1}=search_num;
        end
    end
    if length(ele)>1
        if length(tree(1,:))==2
            tree{1,3}={};
        end
        [tree{1,3},search_table,search_num]=SP_add(ele(2:end),ele_num,tree{1,3},0,search_table,search_num);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif   ~isempty(tree)
    flag_check=0;
    L=length(tree(:,1));
    for i=1:L
        if(tree{i,1}==add_ele)
            flag_check=1;
            tree{i,2}=tree{i,2}+ele_num;
            if flag==1
                search_num(1)=i;
            else
                search_num(end+1)=i;
            end
            if length(ele)>1
                if length(tree(i,:))==2
                    tree{i,3}={};
                end
                [tree{i,3},search_table,search_num]=SP_add(ele(2:end),ele_num,tree{i,3},0,search_table,search_num);
            end
            break
        end
    end
    if flag_check==0
        tree{L+1,1}=add_ele;
        tree{L+1,2}=ele_num;
        if flag==1
            search_num(1)=L+1;
        else
            search_num(end+1)=L+1;
        end
       if add_ele>length(search_table)
            search_table{add_ele,1}{1,1}=search_num;
        else
            search_table{add_ele,1}{end+1,1}=search_num;
        end
        if length(ele)>1
            if length(tree(L+1,:))==2
                tree{L+1,3}={};
            end
            [tree{L+1,3},search_table,search_num]=SP_add(ele(2:end),ele_num,tree{L+1,3},0,search_table,search_num);
        end
    end
end
end








