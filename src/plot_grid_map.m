clear all; clc;close all;
path(path, '../data');
load('costmap.mat');
costmap_index = find(costmap(:,5)==254);
world_axes = costmap(:,1:4);
word_xy = world_axes(costmap_index,:);
% costmap_index = 
% size_x=max(costmap(:,1));
% size_y=max(costmap(:,2));
