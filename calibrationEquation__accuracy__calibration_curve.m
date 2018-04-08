%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%将定标系数保存在一个文件中，其中第一行为增益G，第二行为系统噪声Tsys，第三行为非线性系数alpha
%%每行前6个为时间，后面有16个系数。共16+6=22个数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;%关闭所有figure窗口
[filename,filepath]=uigetfile('*.txt','打开定标系数文件');
complete_file = strcat(filepath,filename);
fidin = fopen(complete_file,'r+');
lineNum = 0;
% fileStruct = dir(complete_file);
% sizeofFile = fileStruct.bytes;
% splitNum = ceil(sizeofFile/1024/7);
format_data = '';gain = zeros(1,16);Tsys = zeros(1,16);alpha = zeros(1,16);
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
            year = sourceData{1,1};
            month = sourceData{1,2};
            day = sourceData{1,3};
            for i = 1:16
                gain(i) = sourceData{1,6+i};     
            end
        elseif lineNum == 2
            for i = 1:16
                Tsys(i) = sourceData{1,6+i};
            end
        elseif lineNum == 3
            for i = 1:16
                alpha(i) = sourceData{1,6+i};
            end
        end        
    else
            continue;
    end%对应外圈的if
end%对应while循环
fclose(fidin);
global dateStr;
dateStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d')];
global xlsFilePath;
xlsFilePath = ['accuracy_',num2str(year,'%02d'),num2str(month,'%02d'),'.xls'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算灵敏度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global sheetNum;sheetNum = 1;
global positionRowNum;positionRowNum = 0;
%calculate_accracy(gain,Tsys,alpha);
calculate_accracy_periodLn(gain,Tsys,alpha);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%画定标曲线
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num = 0;
global T_STEP;global MIN_VALUE;global MAX_VALUE;
T_STEP = 1;MIN_VALUE = 0;MAX_VALUE = 300;
V = zeros(T_STEP*(MAX_VALUE - MIN_VALUE),16);
for T = MIN_VALUE:T_STEP:MAX_VALUE
    num = num + 1;
    for channel = 1:16
        V(num,channel) = gain(channel) * power( (T + Tsys(channel)) , alpha(channel) );
    end
end
plot_calibration_equation(V,alpha);
close all;%关闭所有图像窗口
