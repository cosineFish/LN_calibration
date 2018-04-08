function [status , msginfo] = ...
    write2xls(filePath , title ,rnames, cnames , values , length , row_num)
%write2xls(filePath , title ,rnames, cnames , values , sheetName , length , row_num)
    global dateStr;
    global sheetNum;
    sheetName = [dateStr,'_',num2str(sheetNum)];
    global positionRowNum;
    positionRowNum =  1 + positionRowNum;
    xlswrite(filePath,cellstr(title),sheetName,['A',num2str(positionRowNum)]);%д������Ϣ
    posotionColChar = char(length + 65);
    positionRowNum =  1 + positionRowNum;
    xlswrite(filePath,cellstr(cnames),sheetName,...
        ['B',num2str(positionRowNum),':',...
        posotionColChar,num2str(positionRowNum)]);%д������
    %д������
    xlswrite(filePath,cellstr(transpose(rnames)),sheetName,['A',num2str(positionRowNum + 1),':',...
        'A',num2str(positionRowNum + 3)]);
    positonStr = ['B',num2str(positionRowNum + 1),':',...
        posotionColChar,num2str(positionRowNum + row_num)];
    [status , msginfo] = xlswrite(filePath,values,sheetName,positonStr);
    positionRowNum = positionRowNum + row_num + 1;
end