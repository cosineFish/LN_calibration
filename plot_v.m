function plot_v(Vol,receiver_name)
    global figure_num;
    figure_num = figure_num +1;    
    sz = get(0,'screensize');
    figure('name',num2str(figure_num),'outerposition',sz);
    load checkdata_num.mat lineNum splitNum timeNum
    load checkdata_xtick.mat xticklabel_vol
    for i = 1:8
        min_value = min(Vol(:,i));
        max_value = max(Vol(:,i));
        Vol_aver(i) = mean(Vol(:,i));
        Vol_std(i) = std(Vol(:,i));
        Vol_pp(i) = max_value - min_value;
        subplot(4,2,i);
        plot(1:1:lineNum ,Vol(:,i));
        %ylim([(min_value - 0.05) (max_value + 0.05)]);
        %
        %title(['通道',num2str(i),'电压'],'FontSize',11);
        set(gca,'xtick',1:splitNum:timeNum*splitNum +1);
        set(gca,'xticklabel',xticklabel_vol);
%          ytick_min_value = min_value;%floor(min_value);%floor((min_value - 0.05) * 10)/10;
%         % ytick_interval = floor((ytick_max_value-ytick_min_value)/5* 10)/10;
%         ytick_interval = 0.05;
%          ytick_max_value = max_value;%ceil(max_value);
%          ylim([ytick_min_value ytick_max_value]);
        ylabel(['通道',num2str(i),'电压/V']);
        %set(gca,'ytick',ytick_min_value :ytick_interval:ytick_max_value);
        %set(gca,'FontSize',14);
        %pos = axis;
        hold on;
    end
    global dateStr;
    suptitle([receiver_name,...
        '波段接收机各通道的电压曲线（测量日期：',dateStr,'）']);
    hold off;
    if receiver_name == 'K'
        Vol_dat_K = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_K');
    elseif receiver_name == 'V'
        Vol_dat_V = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_V','-append');
    end
    save2word([dateStr,'vol_report.doc'],['-f',num2str(figure_num)]);
end