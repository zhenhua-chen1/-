clc
clear 
close all
%% ��ȡ����
DataGet()
load data

%% �����㷨
[min_cost,path_len,path,e_h,e_a]=Dijkstra_1(A,dij,B);
[path]=draw_airline(path_len,path);

%% ��ȡ���
disp(['ˮƽ���Ϊ��',(num2str((e_a(path+1))))])
disp(['��ֱ���Ϊ��',(num2str((e_h(path+1))))])
path

