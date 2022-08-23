clc
clear 
close all
dbstop if error
%Dataget()
load data
mt=zeros(T,1);
supply_oil=zeros(T,box);%���Ͳ���
c1_t=zeros(T,3);
Re_i=origin_i*rho;
step=zeros(1,box);%��¼ÿ�빩�ʹ���
epsilon=0.0001;%��С������
t=1;

%% ����̰���㷨
tic
while t<=T
    if  consum_eng(t)~=0
        box_i=find_box(t,Re_i,epsilon);%����̰�Ĳ����ҹ�����    
        [mt,supply_oil,c1_t,Re_i,t]=box_value(box_i,mt,supply_oil,c1_t,Re_i,t,epsilon);%�ҳ�60sƫ��,60s��������ʣ��������ִ����

    else
         [x,y,z] = oCenter(Re_i,data_angle(t));
         mt(t) = Deviation([x,y,z]); %�����ǰƫ��
         c1_t(t,:)=[x,y,z];
    end
 t=t+1;
 disp(['���㵽',num2str(t),'s'])
end
toc

%% ��ͼ
figure(1)
plot3(c1_t(:,1),c1_t(:,2),c1_t(:,3))
hold on
% plot3(c0_t(:,1),c0_t(:,2),c0_t(:,3))
% hold on
% axis([-1 10 -1 10 -1 10])
title('���ı仯����')
figure(2)
% subplot(2,1,1)
% hold on
% plot(supply_oil(:,1))
subplot(6,1,1)
plot(supply_oil(:,1))
title('6���������ı仯����')
subplot(6,1,2)
plot(supply_oil(:,2))
subplot(6,1,3)
plot(supply_oil(:,3))
subplot(6,1,4)
plot(supply_oil(:,4))
subplot(6,1,5)
plot(supply_oil(:,5))
subplot(6,1,6)
plot(supply_oil(:,6))
hold on

figure(3)
plot(sum(supply_oil,2))
title('�����乩������')
min_value=max(mt)