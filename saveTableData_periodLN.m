function saveTableData_periodLN(accuracy,sita,temperature)
    global xlsFilePath;
    global dateStr;
    global sheetNum;
    %load('accuracy.mat','accuracy','sita','temperature');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����׼�����¶�ֵ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    %�¶�ֵ
    title = ['Һ������(��������:',dateStr,')'];
    rnames = {'ƽ��ֵ/K'};  
    for i = 1:8
        cnames_channel(i) = {['ͨ��',num2str(i)]};
    end    
    write2xls(xlsFilePath,['K',title],rnames,cnames_channel,temperature(1:8),length(cnames_channel),1);
    write2xls(xlsFilePath,['V',title],rnames,cnames_channel,temperature(9:16),length(cnames_channel),1);
    %��׼��
    title = ['���ε�ѹ��׼��(��������:',dateStr,')'];
    for i = 1:8
        cnames_channel(i) = {['ͨ��',num2str(i)]};
    end    
    rnames = {'��׼��'};
    write2xls(xlsFilePath,['K',title],rnames,cnames_channel,sita(1:8),length(cnames_channel),1);
    write2xls(xlsFilePath,['V',title],rnames,cnames_channel,sita(9:16),length(cnames_channel),1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����������
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    title = ['���ν��ջ�������(��������:',dateStr,')'];
    rnames = {'������/K'};
    % write2xls(filePath , title ,rnames, cnames , values , length, row_num)
    write2xls(xlsFilePath,['K',title],rnames,cnames_channel,accuracy(1:8),length(cnames_channel),1);
    write2xls(xlsFilePath,['V',title],rnames,cnames_channel,accuracy(9:16),length(cnames_channel),1);
    sheetNum = sheetNum + 1;
end