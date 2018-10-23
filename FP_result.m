function result =FP_result(data,con,L)
result={};
for level=2:length(data) 
    for k=1:level-1
        now2=1;
        for j=1:length(data{level}(:,1))
            fprintf("算con中-----目前: %d-%d層 進度 %d / %d\n",level,k,j,length(data{level}));
            ele=data{level}(j,1:level);
            ele_sup=data{level}(j,1+level);
            tmp=0;
            tmp=nchoosek(ele,k);
            now=now2;
            for l=1:length(tmp)   
                for m=now:length(data{k})  
                    tmp_v=data{k}(m,1:k);
                    if isequal(tmp(l,:),tmp_v)  
                        now=m;
                        if l==1
                            now2=m;
                        end
                        tmp_sup=data{k}(m,1+k);
                        tmp_con=ele_sup/tmp_sup;
                        if tmp_con>=con
                            if isempty(result)
                                result{1,1}=tmp_v;
                                result{1,2}=setdiff(ele,tmp_v);
                                result{1,3}=ele_sup/L;
                                result{1,4}=tmp_con;
                                break;
                            else
                                result{end+1,1}=tmp_v;
                                result{end,2}=setdiff(ele,tmp_v);
                                result{end,3}=ele_sup/L;
                                result{end,4}=tmp_con;
                                break;
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end
fid=fopen('FP_result.txt','w');
for i=1:length(result)
    for j=1:length(result(i,:))
        for k=1:length(result{i,j})
            fprintf(fid,'%d ',result{i,j}(k));
        end
        if j==1
            fprintf(fid,'->');
        elseif j==2
            fprintf(fid,' : ');
        elseif j==3
            fprintf(fid,' , ');
        else
            fprintf(fid,'\r\n');
        end
    end
end
fclose(fid);
end
