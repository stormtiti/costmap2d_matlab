clear all; clc;close all;

length = 60;
width = 60;
minx = 0;
miny = 0;
resolution =0.05;

%绘栅格
i=minx:resolution:minx+length*resolution;
j=miny:resolution:miny+width*resolution;
[x,y] = meshgrid(i,j);
plot(x,y,'k')
hold on
plot(x',y','k')
grid on
%获得栅格坐标
n = 1;
for j = 1:length
    for i = 1:width
   %     p = [x(1,p_index(1)) y(p_index(2),1)]
    p_index = [i j];
    p_x(n) = x(1,p_index(1));
    p_y(n) = y(p_index(2),1);
    n=n+1;
    end
end
p = [p_x' p_y'];%栅格左下点坐标
p_center =[p_x'+resolution/2  p_y'+resolution/2];%栅格中心点坐标
%设置需要膨胀的索引
inflat_index = [30 50];%需要膨胀的索引值
refer_a =[x(1,inflat_index(1)) y(inflat_index(2),1)]

% p_center = 

% 填充需要膨胀的栅格
x1=refer_a(1);
y1=refer_a(2);
x2=refer_a(1)+resolution;
y2=refer_a(2)+resolution;
x_fill=[x1,x2,x2,x1,x1];              
y_fill=[y1,y1,y2,y2,y1];
hold on
fill(x_fill,y_fill,'k');
%计算膨胀栅格与各个栅格的距离
k=1;
for j = 1:length
    for i = 1:width
        p_index = [i j];
        p_x = x(1,p_index(1))+resolution/2;
        p_y = y(p_index(2),1)+resolution/2;
        %欧式距离
        distance_E(k) = distance((refer_a(1)+resolution/2),(refer_a(2)+resolution/2),p_x,p_y);
       %马氏距离
%         distance_E(k) = ((refer_a(1)+resolution/2)-p_x)+abs((refer_a(2)+resolution/2)-p_y);

        k=k+1;
    end       
end
% [distance_diff,idex_distance_E,idex_distance_diff ] = unique(distance_E);%距离中不同的值
% min_distance = min(distance_diff);
% max_distance = max(distance_diff)
% distance = reshape(distance_E,10,10);
% distance =distance';

inscribed_radius = 0.2;
inflation_radius =0.55;
weight = 10;
m=1;
for i=1:length*width
if distance_E(i) == 0
    cost(m) = 254;
else if distance_E(i) <= inscribed_radius
        cost(m) = 253;
    else 
        factor = exp(-1.0*weight*(distance_E(i)-inscribed_radius))
        cost(m) = ceil((253-1)*factor);
    end
end
 m = m+1;
end
cost_ = reshape(cost,length,width);
basic_value = 255;
result =cost_/basic_value;
for j = 1:length
    for i = 1:width
            a =1 - result(i,j)
            inflat_index = [i j];%需要膨胀的索引值
            refer_a =[x(1,inflat_index(1)) y(inflat_index(2),1)]
            % 填充需要膨胀的栅格
            x1=refer_a(1);
            y1=refer_a(2);
            x2=refer_a(1)+resolution;
            y2=refer_a(2)+resolution;
            x_fill=[x1,x2,x2,x1,x1];              
            y_fill=[y1,y1,y2,y2,y1];
            hold on
            fill(x_fill,y_fill,[a a a]);
    end
end

% for j = 1:length
%     for i = 1:width
%       cost_ij = cost(j,i);
%     switch cost_ij
%         case 254
%             [r c] = find(cost_==254);
%             inflat_index = [r c];%需要膨胀的索引值
%             refer_a =[x(1,inflat_index(1)) y(inflat_index(2),1)]
%             % 填充需要膨胀的栅格
%             x1=refer_a(1);
%             y1=refer_a(2);
%             x2=refer_a(1)+resolution;
%             y2=refer_a(2)+resolution;
%             x_fill=[x1,x2,x2,x1,x1];              
%             y_fill=[y1,y1,y2,y2,y1];
%             hold on
%             fill(x_fill,y_fill,'*r','MakerSize',20);
% 
%     case 253
%         
%         [r c] = find(cost_==253);
%         inflat_index = [r c];%需要膨胀的索引值
%         refer_a =[x(1,inflat_index(1)) y(inflat_index(2),1)]
%         % 填充需要膨胀的栅格
%         x1=refer_a(1);
%         y1=refer_a(2);
%         x2=refer_a(1)+resolution;
%         y2=refer_a(2)+resolution;
%         x_fill=[x1,x2,x2,x1,x1];              
%         y_fill=[y1,y1,y2,y2,y1];
%         hold on
%         fill(x_fill,y_fill,'b');
%     otherwise 
%         a=1;
%     end
%     end
% end
%  basic_value=255;
% for j = 1:length
%     for i = 1:width
%         result = cost_(i,j)/basic_value;
%     end
% end
% plot(cost_,'color',[result result result]);
%         

%         
    
% c = linspace(min_distance,maz_distance,length(distance_diff));
% scatter(x,y,10,c,'filled'); 

grid on
axis equal 

