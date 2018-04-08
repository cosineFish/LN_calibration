function plot_v(Vol_31,Vol_42,receiver_name) 
    figure('name',receiver_name);
    lineNum = length(Vol_31(:,1));
    for i = 1:8
        Vol = [Vol_31(:,i);Vol_42(:,i)];
        min_value(i) = min(Vol);
        max_value(i) = max(Vol);
        pp_value(i) = max_value(i) - min_value(i);
        deltaVol = Vol_31(:,i) - Vol_42(:,i);
        Vol_aver(i) = mean(deltaVol);
        Vol_std(i) = std(deltaVol);
        Vol_pp(i) = max(deltaVol) - min(deltaVol);
        subplot(4,2,i);%h(i) = subplot(4,2,i);
        plot(1:1:lineNum ,Vol_31(:,i),'r',...
            1:1:lineNum ,Vol_42(:,i),'b',...
            'LineWidth',3);
        v_gca(i) = gca;
        set(gca,'xtick',1:1:lineNum);
        set(gca,'xticklabel',1:1:lineNum);
        title(['通道',num2str(i)]);
        legend('V3-V1','V4-V2');
        %xlabel('液氮定标次序');
        ylabel('电压差/V');
        set(gca,'FontSize',12);
        hold on;
    end
    Vol_delta = ceil(max(pp_value) * 100) / 100.0;
    for i = 1:8    
        minValue = floor(min_value(i) * 1000) / 1000.0;
        maxValue = minValue + Vol_delta;
        if minValue == maxValue
            maxValue = minValue + 0.01;
        end
        ylnew = [minValue  maxValue];
        set(v_gca(i), 'Ylim', ylnew);
        set(v_gca(i),'ytick',minValue:Vol_delta/5:maxValue);
    end        
    global dateStr;
    suptitle([receiver_name,...
        '波段接收机各通道的电压差曲线（测量日期:',dateStr,',横坐标:液氮定标次序）']);
    set (gcf,'Position',[100,100,1080,800], 'color','w');
    hold off;
    if receiver_name == 'K'
        Vol_delta_K = [Vol_aver;Vol_std;Vol_pp];
        save('delta_Vol.mat','Vol_delta_K');
    elseif receiver_name == 'V'
        Vol_delta_V = [Vol_aver;Vol_std;Vol_pp];
        save('delta_Vol.mat','Vol_delta_V','-append');
    end
end