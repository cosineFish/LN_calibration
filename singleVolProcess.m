%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����ѹ���ļ�
%��������ѹ���һ��ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;clc;
close all;%�ر�����figure����
global dateStr;dateStr = '';
global sheetStr;sheetStr = '';
global xlsFilePath;xlsFilePath = '';
[filename,filepath]=uigetfile('*.txt','��V3-V1�ļ�');
[K_Vol_V31 , V_Vol_V31] = handle_vol_file(filepath,filename);
[filename,filepath]=uigetfile('*.txt','��V4-V2�ļ�');
[K_Vol_V42 , V_Vol_V42] = handle_vol_file(filepath,filename);
lineNum = length(K_Vol_V31(:,1));
global positionRowNum;
positionRowNum = 0;
%�����ջ������ѹ����
plot_v(K_Vol_V31,K_Vol_V42,'K');
plot_v(V_Vol_V31,V_Vol_V42,'V');
%�ѱ�񱣴浽excel��ע��excel�ļ�̫��190KB���ң����ܵ�������д����ȥ�����
saveTableData();
system('taskkill /F /IM EXCEL.EXE');
%���������mat�ļ�
delete_mat();
close all;%�ر�����ͼ�񴰿�