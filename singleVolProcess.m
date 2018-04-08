%%%%%%%%%%%%%%%%%%%%%%%%%%%
%处理电压差文件
%将两个电压差画在一个图中
%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;clc;
close all;%关闭所有figure窗口
global dateStr;dateStr = '';
global sheetStr;sheetStr = '';
global xlsFilePath;xlsFilePath = '';
[filename,filepath]=uigetfile('*.txt','打开V3-V1文件');
[K_Vol_V31 , V_Vol_V31] = handle_vol_file(filepath,filename);
[filename,filepath]=uigetfile('*.txt','打开V4-V2文件');
[K_Vol_V42 , V_Vol_V42] = handle_vol_file(filepath,filename);
lineNum = length(K_Vol_V31(:,1));
global positionRowNum;
positionRowNum = 0;
%画接收机输出电压曲线
plot_v(K_Vol_V31,K_Vol_V42,'K');
plot_v(V_Vol_V31,V_Vol_V42,'V');
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
saveTableData();
system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
delete_mat();
close all;%关闭所有图像窗口