 function DataGet()
% ����������ļ������м��������ڴ�����
mp=0.8; %У���ɹ��ĸ���
data = xlsread('data.xlsx'); %��ȡ����;
data(1,5)=3;
NodeAmount =length(data); %�����ĸ���;
pos = data(1:NodeAmount,2:4);
dij=zeros(NodeAmount,NodeAmount);%������ŷ�Ͼ���;
% lij=zeros(NodeAmount,NodeAmount);%�����Ļ���;
% Rij=zeros(NodeAmount,NodeAmount);%��������İ뾶;
ess=data(2:NodeAmount-1,5);
prob=data(2:NodeAmount-1,6);
% nodetype= [0,ess,0]'; %��ȡУ����;
for i = 1:NodeAmount
   for j = i+1:NodeAmount
        dij(i,j)=sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2+(pos(i,3)-pos(j,3))^2);
        dij(j,i)=dij(i,j);
   end
end
Delta=0.001;%��СУ����λ;
theta=30;%���������λ;
alhpa_1=25;
alhpa_2=15;
Beta_1=20;
Beta_2=25;
MaxR = 14500;%���ת��뾶;
save data

 end

% D=zeros(row,row);
% for i=1:row
%     for j=i+1:row
%         D(i,j)=((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2)^0.5;
%         D(j,i)=D(i,j);
%     end
% end




