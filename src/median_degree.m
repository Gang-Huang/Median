function median_degree
cd ../
cd('venmo_input');
data = loadjson('venmo-trans.txt');
num = length(data);
a = cell(1,num);
payments = cell(num,2);
for i = 1:num
    a{i} = data{i}.created_time;
    payments{i,1} = data{i}.target;
    payments{i,2} = data{i}.actor;
end
    date = datetime(a,'InputFormat','yyyy-MM-dd''T''HH:mm:ss''Z');
    med = zeros(1, num);
    med(1) = 1;
    ini_paysets = payments(1,:);
    clock = date(1);
    
    for i = 2:num
        if date(i) > clock
            ini_paysets = payments(i,:);
            clock = date(i);
        end
        paysets = ini_paysets;
        adj = ones(2) - eye(2);
        
        for j = i:-1:1
            if clock - date(j) < seconds(60)
                [paysets, adj] = strcmb(paysets, payments(j,:),adj);
            elseif clock - date(max(1,j-1)) < seconds(60)
            else
                break;
            end
        end
        med(i) = median(sum(adj));
    end
    
    function [p, q] = strcmb(s1, s2, adj)
        a1 = length(s1);
        count = 0;
        index = zeros(1,2);
        for k = 1:2
            tf = strcmp(s2(k), s1);
            if sum(tf)>0
                    index(k) = find(tf, 1);
            else
                    count = count+1;
                    index(k) = length(s1) + count;
            end
        end
        p = cell(1,max(max(index),a1));
        q = zeros(max(max(index),a1));
        q(1:a1,1:a1) = adj;
        q(index,index) = ones(2)-eye(2);
        p(1:a1) = s1;
        for i2 = 1:2
                if index(i2) > a1
                    p(index(i2)) = s2(i2);
                end
        end
    end

med = floor(med*100)/100;
cd ../
cd('venmo_output');
fileID = fopen('output.txt','w');
fprintf(fileID,'%3.2f\r\n', med);
fprintf('%3.2f\r\n',med);
fclose(fileID);

cd ../

end