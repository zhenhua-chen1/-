clc
clear all
DataGet()
load data
pop_size=10;%��Ⱥ��ģ
best_line=[];
%% �Ŵ��㷨����
Iter_max=10;%����������
w=[0.6,0.3,0.1];%��Ӧ�Ժ�����Ӧϵ��
cp=0.6; %�������
mp=0.1;% �������
tic

%% ����ͽ���
for i=1:pop_size
    Passenger_pop(i,1:Passenger)=randperm(Passenger)+rand(1,Passenger);
end
% fitness= ga_fitness2(Passenger_pop,w);
fitness= ga_fitness(Passenger_pop);
best_fit=min(fitness);


%% �Ŵ��㷨���
for t=1:Iter_max
    Passenger_pop2 = ga_choose( Passenger_pop,fitness );
    Passenger_pop2 = ga_cross( Passenger_pop2,cp);
    Passenger_pop2 = ga_mutation(Passenger_pop2 ,mp);
%     fitness2= ga_fitness2(Passenger_pop2,w);
    fitness2= ga_fitness(Passenger_pop2);
    best_fit2=min(fitness2);
    if best_fit2<best_fit
        fitness=fitness2;
        Passenger_pop=Passenger_pop2;
        best_fit=best_fit2;
    end
    best_line=[best_line,best_fit];
    disp(['��',num2str(t),'�������Ϊ��',num2str(best_fit)]);
end

% ��ͼ
plot(best_line);
xlabel('��������');
ylabel('��Ӧ�Ժ���');
title('�Ŵ��㷨����ͼ');
[~,pos]=min(fitness);
Passenger_pop=Passenger_pop(pos,:);
[Cij,best_tension]=func(Passenger_pop);
Cij=assign_flight(Cij);%����̰���㷨���

%% ���
[a,b]=find(Cij==1);
result=[a,b];
b2=unique(b);
for i=1:length(a)
    disp(['��',num2str(a(i)),'��������',num2str(b(i)),'�ǻ���']);
end
disp(['һ��',num2str(length(a)),'�����౻����'])
disp(['һ��',num2str(length(b2)),'���ǻ��ڱ�ʹ��'])
disp(['���Ŷ�Ϊ��',num2str(best_tension)])
toc