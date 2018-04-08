%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%文件是V4-V2或者V3-V1
%每行有24个数据，前6个是时间，中间有2个数据，后面16个是电压差
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [K_Vol , V_Vol] = handle_vol_file(filepath,filename)
%处理电压数据
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    lineNum = 0;
    format_data = '';
    for i = 1:1:24 %时间无毫秒
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
            end
            for i = 1:8
                K_Vol(lineNum,i) = sourceData{1,8+i};
                V_Vol(lineNum,i) = sourceData{1,16+i};
            end
        else
                continue;
        end%对应外圈的if
    end%对应while循环
    fclose(fidin);
    global dateStr;
    global sheetStr;
    global xlsFilePath;
    %if dateStr == ''%(sheetStr == '') % (xlsFilePath == '')
        dateStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d')];      
        sheetStr = ['volData_',num2str(year,'%02d'),num2str(month,'%02d')];
        xlsFilePath = [sheetStr,'.xls'];
    %end
end