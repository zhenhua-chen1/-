clc
clear all
DataGet()
load data
fitness=inf;%��Ӧ�Ժ�������תʱ�䣩
Iter_max=100;%����������
for iter=1:Iter_max
    temp_Cij=zeros(Z,N);
    temp_fitness=0;
    for p=1:Passenger
        i1=data2(p,2);
        i2=data2(p,4);
        pos1=find_pos(i1,date_a(p),data1(:,3),data1(:,16));%�ҵ���Ӧ�����������
        pos2=find_pos(i2,date_d(p),data1(:,8),data1(:,17));
        if ~isempty(pos1)&&~isempty(pos2)
                j1=find(Aij(pos1,:));%�ҵ�����Լ���ĵǻ���
                j1=is_coflict(pos1,j1,temp_Cij,Z,Bii);% ��j1��pos1�������Ƿ��ͻ
            if ~isempty(j1)
                j1=j1(ceil(rand(1)*length(j1)));%���ѡһ���ǻ���
                if sum(temp_Cij(pos1,:)==1)==0
                    temp_Cij2=temp_Cij;
                    temp_Cij2(pos1,j1)=1;
                end
            end
                j2=find(Aij(pos2,:));
                j2=is_coflict(pos2,j2,temp_Cij2,Z,Bii);% ��j2��pos2�������Ƿ��ͻ
             if ~isempty(j1)&&~isempty(j2)
                    j2=j2(ceil(rand(1)*length(j2)));
                temp_fitness2=calculate_fitness(pos1,j1,pos2,j2,data1,transfer_time);
                temp_fitness=temp_fitness+temp_fitness2;
                if sum(temp_Cij(pos1,:)==1)==0
                    temp_Cij(pos1,j1)=1;
                end
                if sum(temp_Cij(pos2,:)==1)==0
                    temp_Cij(pos2,j2)=1;
                end
             end
        end
    end
    %����Cij
    if temp_fitness<fitness
        fitness=temp_fitness;
        Cij=temp_Cij;
    end
   disp(['��',num2str(iter),'�����Ľ��Ϊ:',num2str(fitness)])
end 

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
