%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%������������������ݱ�����һ���ļ��У����е�һ�У���Ч�У�Ϊ��׼��sita���ڶ���Ϊ��Ӧ���¶�T
%%ÿ��ǰ6��Ϊʱ�䡣��һ�к�����16�����ݣ��ڶ��к���Ҳ��16������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function calculate_accracy_periodLn(gain,Tsys,alpha)
    [filename,filepath]=uigetfile('*.txt','�����������������ļ�');
    complete_file = strcat(filepath,filename);
    fidin = fopen(complete_file,'r+');
    lineNum = 0;
    format_data = '';
    accuracy = zeros(1,16);sita = zeros(1,16);
    for i = 1:1:22
        format_data = strcat(format_data,'%f');
    end
    while ~feof(fidin)         %�ж��Ƿ�Ϊ�ļ�ĩβ
        tline = fgetl(fidin);         %���ļ�����   
        tline = strtrim(tline);
        if isempty(tline)
            continue;
        end
        if ~contains(tline,'#')
            lineNum = lineNum + 1;
            sourceData = textscan(tline , format_data);
            if lineNum == 1
                for i = 1:16
                    sita(i) = sourceData{1,6+i};     
                end
            elseif lineNum == 2
                for i = 1:16
                    temperature(i) = sourceData{1,6+i};
                end
            end     
        else
                continue;
        end%��Ӧ��Ȧ��if
    end%��Ӧwhileѭ��
    fclose(fidin);
    for channel_num = 1:16
        %����ƫ����
        derivative = gain(channel_num) * alpha(channel_num) * power((temperature(channel_num) + Tsys(channel_num)) , alpha(channel_num)-1 );
        %���󾫶�
        accuracy(channel_num) = sita(channel_num) / derivative;
    end
    %save('accuracy.mat','accuracy','sita','temperature');
    saveTableData_periodLN(accuracy,sita,temperature);
    %system('taskkill /F /IM EXCEL.EXE');
end