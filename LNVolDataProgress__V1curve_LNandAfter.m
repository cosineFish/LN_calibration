%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��Һ������ʱ���V1���������Һ�����ڲ�����V1���δ�ŵ�ͬһ���ļ��У���������
%ÿһ�е�ǰ6��Ϊʱ�䣬��7~22���ǵ�ѹ����22������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
close all;%�ر�����figure����
[filename,filepath]=uigetfile('*.txt','���ļ�');
handle_vol_file(filepath,filename);
%�����ջ������ѹ����
K_Vol(:,5) = K_Vol(:,4);
plot_v(K_Vol,'K');
plot_v(V_Vol,'V');
%�ѱ�񱣴浽excel��ע��excel�ļ�̫��190KB���ң����ܵ�������д����ȥ�����
global sheetNum;
sheetNum = 1;
saveTableData();
system('taskkill /F /IM EXCEL.EXE');
%���������mat�ļ�
delete_mat();
close all;%�ر�����ͼ�񴰿�