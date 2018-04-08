function saveTableData()
    global xlsFilePath;
    global dateStr;
    global sheetNum;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����ѹ���ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load checkdata_Vol.mat Vol_dat_K Vol_dat_V
    for i = 1:8
        cnames_vol(i) = {['ͨ��',num2str(i)]};
    end
    title = ['���ν��ջ���ͨ����ѹ(��������:',dateStr,'��'];
    global rnames;
    rnames = {'��ֵ/V','��׼��/V','���ֵ/V'};%�޸ĵ�λ
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_dat_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_dat_V,length(cnames_vol));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����ѹ��ֵ���ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    load('vol_average.mat','K_vol_sum', 'V_vol_sum'); 
    stepNum = 2;
    title = ['���ν��ջ���ͨ����ѹ��ֵ(��������:',dateStr,'��'];
    rnames = '��ֵ/V';%�޸ĵ�λ
    vol_average_write2xls(xlsFilePath,['K',title],cnames_vol,K_vol_sum,length(cnames_vol),stepNum);
    vol_average_write2xls(xlsFilePath,['V',title],cnames_vol,V_vol_sum,length(cnames_vol),stepNum);    
    sheetNum = sheetNum + 1;
end