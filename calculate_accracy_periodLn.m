%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%将求灵敏度所需的数据保存在一个文件中，其中第一行（有效行）为标准差sita，第二行为对应的温度T
%%每行前6个为时间。第一行后面有16个数据，第二行后面也有16个数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function calculate_accracy_periodLn(gain,Tsys,alpha)
    [filename,filepath]=uigetfile('*.txt','打开灵敏度所需数据文件');
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    lineNum = 0;
    format_data = '';
    accuracy = zeros(1,16);sita = zeros(1,16);
    for i = 1:1:22
        format_data = strcat(format_data,'%f');
    end
    while ~feof(fidin)         %判断是否为文件末尾
        tline = fgetl(fidin);         %从文件读行   
        tline = strtrim(tline);
        if isempty(tline)
            continue;
        end
        if ~contains(tline,'#')
            lineNum = lineNum + 1;
            sourceData = textscan(tline , format_data);
            if lineNum == 1
                for i = 1:16
                    sita(i) = sourceData{1,6+i};     
                end
            elseif lineNum == 2
                for i = 1:16
                    temperature(i) = sourceData{1,6+i};
                end
            end     
        else
                continue;
        end%对应外圈的if
    end%对应while循环
    fclose(fidin);
    for channel_num = 1:16
        %先求偏导数
        derivative = gain(channel_num) * alpha(channel_num) * power((temperature(channel_num) + Tsys(channel_num)) , alpha(channel_num)-1 );
        %再求精度
        accuracy(channel_num) = sita(channel_num) / derivative;
    end
    %save('accuracy.mat','accuracy','sita','temperature');
    saveTableData_periodLN(accuracy,sita,temperature);
    %system('taskkill /F /IM EXCEL.EXE');
end