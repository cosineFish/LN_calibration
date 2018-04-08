function plot_v(Vol,receiver)
    load('num_HRA001.mat','dataNum', 'xtickNum','splitDataNum');
    load('volData_xtick.mat','xticklabel');
    global dateStr;
    if receiver == 'K' || receiver == 'k'
        load('vol_HRA001.mat','K_Vol_HRA');
        vol_HRA = K_Vol_HRA;
    elseif receiver == 'V' || receiver == 'v'
        load('vol_HRA001.mat' , 'V_Vol_HRA');
        vol_HRA = V_Vol_HRA;
    else
        return;
    end
    for circle_num = 1:2
        figure('name',[num2str(circle_num),'电压曲线']);
        for fig_num = 1:4
            channel_num = fig_num + 4*(circle_num-1);
            x_num_HRA = 1;
            for num = 1:1:length(vol_HRA(:,channel_num))
               HRA_data = vol_HRA(num,channel_num);
               if  HRA_data ~= 0
                   x_HRA(x_num_HRA) = num;
                   y_HRA(x_num_HRA) = HRA_data;
                   x_num_HRA = x_num_HRA + 1;
               end              
            end 
            x_num_HRA = x_num_HRA - 1;
            min_value(channel_num) = min(Vol(:,channel_num));
            max_value(channel_num) = max(Vol(:,channel_num));
            Vol_aver(channel_num) = mean(Vol(:,channel_num));
            Vol_std(channel_num) = std(Vol(:,channel_num));
            Vol_pp(channel_num) = max_value(channel_num) - min_value(channel_num);
            subplot(2,2,fig_num);%h(i) = subplot(4,2,i);
            %scatter(x_HRA(1:splitDataNum),y_HRA(1:splitDataNum),'dk');
            plot(x_HRA(1:splitDataNum) ,y_HRA(1:splitDataNum),'dr',...
                x_HRA(splitDataNum+1:x_num_HRA),y_HRA(splitDataNum+1:x_num_HRA),'b',...
               'LineWidth',2);
%             plot(x_HRA,y_HRA,'r',...
%                 x_HRA(1:splitDataNum),y_HRA(1:splitDataNum),'dk','LineWidth',2);
            legend('液氮定标电压','周期测量电压');
            set(gca,'FontSize',14);
            v_gca(channel_num) = gca;
            set(gca,'xtick',xtickNum);
            set(gca,'xticklabel',xticklabel);
            ylabel(['通道',num2str(channel_num),'电压/V']);
            hold on;
        end
        suptitle([receiver,...
            '波段接收机各通道的电压曲线（测量日期：',dateStr,'）']);
        set(gca,'FontSize',14);
        set (gcf,'Position',[100,100,1080,800], 'color','w');
        hold off;
    end
    Vol_delta = ceil(max(Vol_pp) * 100) / 100.0;
    for channel_num = 1:8    
        minValue = floor(min_value(channel_num) * 1000) / 1000.0;
        maxValue = minValue + Vol_delta;
        ylnew = [minValue  maxValue];
        set(v_gca(channel_num), 'Ylim', ylnew);
        set(v_gca(channel_num),'ytick',minValue:Vol_delta/5:maxValue);
    end        
    %linkaxes(h);
    if receiver == 'K'
        Vol_dat_K = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_K');
    elseif receiver == 'V'
        Vol_dat_V = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_V','-append');
    end
    %save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end