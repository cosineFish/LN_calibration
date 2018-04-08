function saveTableData()
    global xlsFilePath;
    global dateStr;
    global sheetNum;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存电压数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load checkdata_Vol.mat Vol_dat_K Vol_dat_V
    for i = 1:8
        cnames_vol(i) = {['通道',num2str(i)]};
    end
    title = ['波段接收机各通道电压(测量日期:',dateStr,'）'];
    global rnames;
    rnames = {'均值/V','标准差/V','峰峰值/V'};%修改单位
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_dat_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_dat_V,length(cnames_vol));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存电压均值数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    load('vol_average.mat','K_vol_sum', 'V_vol_sum'); 
    stepNum = 2;
    title = ['波段接收机各通道电压均值(测量日期:',dateStr,'）'];
    rnames = '均值/V';%修改单位
    vol_average_write2xls(xlsFilePath,['K',title],cnames_vol,K_vol_sum,length(cnames_vol),stepNum);
    vol_average_write2xls(xlsFilePath,['V',title],cnames_vol,V_vol_sum,length(cnames_vol),stepNum);    
    sheetNum = sheetNum + 1;
end