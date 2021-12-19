clc
clear 
close all
%% ��ȡ����
DataGet()
load data


%% ��������
A=1;% ѡ��A��;
B=NodeAmount;% ѡ��B��;
Itex_max=1000;%��������
all_e_a=[];
all_e_h=[];
n=20;
best_path=zeros(Itex_max,20);
tic

%% �����㷨
for i=1:Itex_max
    [c,po,e_h,e_a,e_h_1,e_a_1,prob_e]=Dijkstra_2(A,dij);
    [min_cost,path_len,path]=Search_path(B,NodeAmount,c,A,po);
    best_path(i,1:path_len)=path;
    best_path(i,path_len+1)=min_cost;
    all_e_a=[all_e_a;e_a];
    all_e_h=[all_e_h;e_h];
end

%% ��ȡ���
[path,idx,M]=unique(best_path,'rows');%ȥ���ظ�·��
e_a=all_e_a(idx,:);%��ȡ���
e_h=all_e_h(idx,:);%��ȡ���
N=tabulate(M);%�ҵ�·������Ƶ��
[pro,idex]=max(N(:,2));
pro=pro/Itex_max*100;%�������
path=path(idex,:);
e_a=e_a(idex,:);%��ȡ���
e_h=e_h(idex,:);%��ȡ���
path(find(path==0))=[];
path=path(1:end-1);
min_cost=path(end);

disp(['��·��:',num2str(path-1),' ���ֵĸ���Ϊ:',num2str(pro),'%'])
disp(['ˮƽ���Ϊ��',(num2str((e_a(path))))])
disp(['��ֱ���Ϊ��',(num2str((e_h(path))))])
toc
disp('��ʼ��ͼ')

%% ��ͼ
draw(path,pos)

