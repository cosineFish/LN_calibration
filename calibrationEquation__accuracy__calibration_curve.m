%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%������ϵ��������һ���ļ��У����е�һ��Ϊ����G���ڶ���Ϊϵͳ����Tsys��������Ϊ������ϵ��alpha
%%ÿ��ǰ6��Ϊʱ�䣬������16��ϵ������16+6=22������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;%�ر�����figure����
[filename,filepath]=uigetfile('*.txt','�򿪶���ϵ���ļ�');
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
while ~feof(fidin)         %�ж��Ƿ�Ϊ�ļ�ĩβ
    tline = fgetl(fidin);         %���ļ�����   
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
    end%��Ӧ��Ȧ��if
end%��Ӧwhileѭ��
fclose(fidin);
global dateStr;
dateStr = [num2str(year,'%02d'),num2str(month,'%02d'),num2str(day,'%02d')];
global xlsFilePath;
xlsFilePath = ['accuracy_',num2str(year,'%02d'),num2str(month,'%02d'),'.xls'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global sheetNum;sheetNum = 1;
global positionRowNum;positionRowNum = 0;
%calculate_accracy(gain,Tsys,alpha);
calculate_accracy_periodLn(gain,Tsys,alpha);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������
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
close all;%�ر�����ͼ�񴰿�
