clear all; clc;close all;
path(path, '../data');
load('costmap.mat');
size_x=max(costmap(:,1));
size_y=max(costmap(:,2));
resolution = 20
map = robotics.BinaryOccupancyGrid(size_x,size_y,resolution,'grid');
costmap_index = find(costmap(:,5)==254);
world_axes = costmap(:,3:4);
xy = world_axes(costmap_index,:)-0.05;

setOccupancy(map,xy,1);
show(map);

hold on
plot(xy(:,1),xy(:,2),'.r')
hold on
grid on
plot([-1.5 -8.6],[6.5 -0.6],'*r','MarkerSize',20);
 set(gca,'XTick',-1.475:0.25:6.475,'YTick',-8675:0.25:-0.625)
axis equal;
% xlim([-2 8])
% ylim([-9 -1])





