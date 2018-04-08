%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%将液氮定标时候的V1、结束后对液氮周期测量的V1依次存放到同一个文件中，画出曲线
%每一行的前6个为时间，第7~22个是电压，共22个数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
close all;%关闭所有figure窗口
[filename,filepath]=uigetfile('*.txt','打开文件');
handle_vol_file(filepath,filename);
%画接收机输出电压曲线
K_Vol(:,5) = K_Vol(:,4);
plot_v(K_Vol,'K');
plot_v(V_Vol,'V');
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
global sheetNum;
sheetNum = 1;
saveTableData();
system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
delete_mat();
close all;%关闭所有图像窗口