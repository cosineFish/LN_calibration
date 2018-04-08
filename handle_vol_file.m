function handle_vol_file(filepath,filename)
%仅适用于处理同一天的数据，不能跨日期
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    lineNum = 0;
    fileStruct = dir(complete_file);
    sizeofFile = fileStruct.bytes;
    if sizeofFile > 1024 * 1000
        splitNum = ceil(sizeofFile/1024/2);
    elseif sizeofFile > 1024 * 500
        splitNum = ceil(sizeofFile/1024/4);
    else
        splitNum = ceil(sizeofFile/1024/8);
    end
    format_data = '';data_count = 0;%记录有效数值的个数
    for i = 1:1:22 %时间无毫秒
        format_data = strcat(format_data,'%f');
    end
    while ~feof(fidin)         %判断是否为文件末尾
        tline = fgetl(fidin);         %从文件读行   
        tline = strtrim(tline);
        if isempty(tline)
            continue;
        end
        if isempty(strfind(tline,'#'))
            lineNum = lineNum + 1;
            sourceData = textscan(tline , format_data);
            if lineNum == 1
                year = sourceData{1,1};
                month = sourceData{1,2};
                day = sourceData{1,3};
                start_hour = sourceData{1,4};
                start_min = sourceData{1,5};
                start_sec = sourceData{1,6};
                base_time_value = ...%day * 24 * 3600 + ...
                    start_hour * 3600 + start_min * 60 + start_sec - 1;
                old_time_value = base_time_value;
                timeNum = 1;
                hour(timeNum) = start_hour;
                minute(timeNum) = start_min; 
                second(timeNum) = start_sec;
                xtickNum(timeNum) = timeNum;
            end
            current_hour = sourceData{1,4};
            if sourceData{1,3} ~= day
                current_hour = current_hour + 24;
            end
            current_min = sourceData{1,5}; 
            current_sec = sourceData{1,6};
            current_time_value = ...
                current_hour * 3600 + current_min * 60 + current_sec;
            dataNum = current_time_value - base_time_value;
            if current_time_value - old_time_value > 480%时间间隔大于8min
                    splitDataNum = data_count;%记录开始做周期测量的时间
            end        
            if dataNum > 0 
                for i = 1:8
                    K_Vol_HRA(dataNum,i) = sourceData{1,6+i};
                    V_Vol_HRA(dataNum,i) = sourceData{1,14+i};
                end
                data_count = data_count + 1;
                if (dataNum-xtickNum(timeNum)) >= 1800 && ...
                        mod(lineNum,splitNum) < 10 && mod(lineNum,splitNum) > 0 
                    timeNum = timeNum + 1;
                    hour(timeNum) = current_hour;
                    if current_hour >= 24
                        current_hour = current_hour - 24;
                    end
                    minute(timeNum) = current_min; 
                    second(timeNum) = current_sec;
                    xtickNum(timeNum) = dataNum;
                end
                old_time_value = current_time_value;
            end        
        else
                continue;
        end%对应外圈的if
    end%对应while循环
    fclose(fidin);
    for i = 1:timeNum
        xlabel_str = [num2str(hour(i),'%02d'),':',num2str(minute(i),'%02d'),':',...
            num2str(second(i),'%02d')];
        xticklabel{i} = xlabel_str;
    end
    save('volData_xtick.mat','xticklabel');
    final_time_value = current_time_value;%最后一个数据的时间
    save('num_HRA001.mat','base_time_value','final_time_value',...
        'dataNum', 'xtickNum','splitDataNum');
    save('vol_HRA001.mat','K_Vol_HRA', 'V_Vol_HRA');
    global dateStr;
    dateStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d')];
    global xlsFilePath;
    xlsFilePath = ['volData_',num2str(year,'%02d'),num2str(month,'%02d'),'.xls'];
end