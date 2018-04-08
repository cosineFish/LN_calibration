function saveTableData()
    global xlsFilePath;
    global dateStr;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存电压数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load('delta_Vol.mat','Vol_delta_K','Vol_delta_V');
    for i = 1:8
        cnames_vol(i) = {['通道',num2str(i)]};
    end
    title = ['波段接收机各通道电压差V31-V42(测量日期:',dateStr,'）'];
    global rnames;
    rnames = {'均值/mV','标准差','峰峰值/mV'};%修改单位
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_delta_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_delta_V,length(cnames_vol));
end