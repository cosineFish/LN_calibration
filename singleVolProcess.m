clear all;clc;
close all;%关闭所有figure窗口
[filename,filepath]=uigetfile('*.txt','打开文件');
complete_file = strcat(filepath,filename);
fidin = fopen(complete_file,'r+');
lineNum = 0;timeNum = 0;
fileStruct = dir(complete_file);
sizeofFile = fileStruct.bytes;
splitNum = ceil(sizeofFile/1024/5);
format_data = '';
for i = 1:1:86
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
            year = sourceData{1,1};
            month = sourceData{1,2};
            day = sourceData{1,3};
            start_hour = sourceData{1,4};
        end
        if mod(lineNum,splitNum)==1
            timeNum = timeNum + 1;
            hour(timeNum) = sourceData{1,4};
            minute(timeNum) = sourceData{1,5}; 
            second(timeNum) = sourceData{1,6};
        end
        for i = 1:8
            K_Vol(lineNum,i) = sourceData{1,68+i};
            V_Vol(lineNum,i) = sourceData{1,76+i};
        end
    else
            continue;
    end%对应外圈的if
end%对应while循环
fclose(fidin);
save('checkdata_num.mat','lineNum', 'splitNum', 'timeNum');
global dateStr;
dateStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d')];
global sheetStr;
sheetStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d'),num2str(start_hour,'%02d')];
global xlsFilePath;
xlsFilePath = ['vol_',num2str(year,'%02d'),num2str(month,'%02d'),'.xls'];
for i = 1:timeNum
    xlabel_str = [num2str(hour(i),'%02d'),':',num2str(minute(i),'%02d'),':',num2str(second(i),'%02d')];
    xticklabel{i} = xlabel_str;
    xlabel_vol_str = [num2str(hour(i),'%02d'),':',num2str(minute(i),'%02d')];
    xticklabel_vol{i} = xlabel_vol_str;
end
save checkdata_xtick.mat xticklabel xticklabel_vol
global rnames;
rnames = {'均值/℃','标准差/℃','峰峰值/℃'};
global figure_num;
figure_num = 0;
global legend_rect_up;
global lengend_rect_down;
legend_rect_up = 'SouthEast';%[0.8 0.7 0.1 0.05];
lengend_rect_down = 'NorthEast';%[0.75 0.5 0.1 0.05];
global positionRowNum;
positionRowNum = 0;
%画接收机输出电压曲线
plot_v(K_Vol,'K');
plot_v(V_Vol,'V');
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
saveTableData();
system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
delete_mat();
close all;%关闭所有图像窗口