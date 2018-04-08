function plot_calibration_equation(Vol,alpha)
    global T_STEP;global MIN_VALUE;global MAX_VALUE;
    global dateStr;
    for num = 1:4
        figure('name',[num2str(num),'-定标方程曲线']);
        if(num == 1)
            receiver_name = 'K';channel_num = 0;channel_flag = 1;
        elseif(num == 3)
            receiver_name = 'V';channel_num = 0;%通道号清0
            channel_flag = 2;
        end
        for fig_num = 1 : 4
            subplot(2,2,fig_num);
            channel_num = channel_num + 1;
            plot(MIN_VALUE:1:MAX_VALUE*T_STEP ,Vol(:,channel_num * channel_flag));
            v_gca(fig_num) = gca;
            %set(gca,'xtick',MIN_VALUE:T_STEP:MAX_VALUE);
            %set(gca,'xticklabel',xticklabel_vol);
            xlabel('亮温T/K');
            ylabel('电压/V');
            title(['通道',num2str(channel_num),',alpha = ',num2str(alpha(channel_num*channel_flag))]);
            set(gca,'FontSize',14);
            grid on;
            hold on;
        end
        suptitle([receiver_name,...
            '波段接收机各通道的定标曲线（测量日期：',dateStr,'）']);
        set (gcf,'Position',[100,100,1000,800], 'color','w');
        hold off;
    end
end