function saveTableData()
    global xlsFilePath;
    global dateStr;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����ѹ���ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load('delta_Vol.mat','Vol_delta_K','Vol_delta_V');
    for i = 1:8
        cnames_vol(i) = {['ͨ��',num2str(i)]};
    end
    title = ['���ν��ջ���ͨ����ѹ��V31-V42(��������:',dateStr,'��'];
    global rnames;
    rnames = {'��ֵ/mV','��׼��','���ֵ/mV'};%�޸ĵ�λ
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_delta_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_delta_V,length(cnames_vol));
end