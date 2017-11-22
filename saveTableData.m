function saveTableData()
    global xlsFilePath;
    global dateStr;
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
end