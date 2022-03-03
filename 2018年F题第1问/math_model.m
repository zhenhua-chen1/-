clc
clear all
DataGet()
load data 

%% ������߱���
xij=binvar(Z,N);
yj=binvar(1,N);
disp('���߱����������')

%% ����Ŀ�꺯��
max=sum(sum(xij));
min=sum(yj);
disp('Ŀ�꺯���������')

%% ����Լ������
CX=[]; 
for i1=1:Z
    for i2=1:Z
        if i1~=i2
            for j=1:N
                CX=[CX;xij(i1,j)+xij(i2,j)<=1-Bii(i1,i2)];
            end
        end
    end
end

for i=1:Z
    for j=1:N
        CX=[CX;xij(i,j)<=yj(j),xij(i,j)<=Aij(i,j)];
    end
end

for j=1:N
    CX=[CX;sum(xij(i,:),2)==1];
end

disp('Լ������������ɣ���ʼ���')
opt = sdpsettings('solver','mosek'); % set solver, ��cplex��
Sol = optimize(CX,-max+min,opt);

min=double(min)
max=double(max)
xij=double(xij)
yi=double(yj)
