function A=search_array(x,y)%%% x=search_table  y=tree
for i=1:length(x)
    tmp_y=y;
    for j=1:length(x{i,1})
        A{i,1}(j)=tmp_y{x{i,1}(j),1};
        tmp=tmp_y;
        if(j<length(x{i,1}))
        tmp_y={};
        tmp_y=tmp{x{i,1}(j),3};
        end
    end
    A{i,2}=tmp_y{x{i,1}(end),2};
end
end