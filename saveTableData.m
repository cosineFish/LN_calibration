function saveTableData(accuracy,sita,temperature)
    global xlsFilePath;
    global dateStr;
    global sheetNum;
    %load('accuracy.mat','accuracy','sita','temperature');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存标准差与温度值
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    %温度值
    title = ['温度(测量日期:',dateStr,')'];
    rnames = {'温度/K'};  
    cnames = {'平均值'};
    write2xls(xlsFilePath,title,rnames,cnames,temperature,length(cnames),1);
    %标准差
    title = ['波段电压标准差(测量日期:',dateStr,')'];
    for i = 1:8
        cnames_channel(i) = {['通道',num2str(i)]};
    end    
    rnames = {'标准差'};
    write2xls(xlsFilePath,['K',title],rnames,cnames_channel,sita(1:8),length(cnames_channel),1);
    write2xls(xlsFilePath,['V',title],rnames,cnames_channel,sita(9:16),length(cnames_channel),1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存灵敏度
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    title = ['波段接收机灵敏度(测量日期:',dateStr,')'];
    rnames = {'灵敏度/K'};
    % write2xls(filePath , title ,rnames, cnames , values , length, row_num)
    write2xls(xlsFilePath,['K',title],rnames,cnames_channel,accuracy(1:8),length(cnames_channel),1);
    write2xls(xlsFilePath,['V',title],rnames,cnames_channel,accuracy(9:16),length(cnames_channel),1);
    sheetNum = sheetNum + 1;
end