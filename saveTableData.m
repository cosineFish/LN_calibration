function saveTableData()
    global xlsFilePath;
    global dateStr;
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
end