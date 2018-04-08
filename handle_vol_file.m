%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ļ���V4-V2����V3-V1
%ÿ����24�����ݣ�ǰ6����ʱ�䣬�м���2�����ݣ�����16���ǵ�ѹ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [K_Vol , V_Vol] = handle_vol_file(filepath,filename)
%�����ѹ����
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    lineNum = 0;
    format_data = '';
    for i = 1:1:24 %ʱ���޺���
        format_data = strcat(format_data,'%f');
    end
    while ~feof(fidin)         %�ж��Ƿ�Ϊ�ļ�ĩβ
        tline = fgetl(fidin);         %���ļ�����   
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
        end%��Ӧ��Ȧ��if
    end%��Ӧwhileѭ��
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