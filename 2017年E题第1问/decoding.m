function [Route,fitness,Rc_Ca]=decoding(P)
% DataGet()
load data
%% �����ʼ����
De=floor(100*(abs(P)-floor(abs(P))));%ȡС��
Ten=floor(De/10);%ȡС���ĵ�һλ
Sin=De-Ten*10;%ȡС���ĵڶ�λ
Z_24=mod(Ten+1,6)+1;%ת�ص�
F_48=Sin/10*60+1;%�����λ
P1=abs(floor(P));%ȡ���Ӿ���ֵ
P1=[P1,F_48];
P1(find(P1==0))=[];%ȥ0
C=unique_unsorted(P1);%ȥ��
if length(C)~=2*vehicle
    for i=P1  %Ѱ��1-60������
        j=F+1-i;
       if ~ismember(j,C) 
           C(length(C)+1)=j;
           if length(C)==2*vehicle  %�ӵ�ԭ��������λ��
               break
           end
       end
    end
end
if length(C)~=2*vehicle
    for i=1:F
     if ~ismember(i,C) 
       C(length(C)+1)=i;
       if length(C)==2*vehicle  %�ӵ�ԭ��������λ��
           break
       end
      end
    end
end
P1=C;
assign=[P1(1:vehicle);Z_24;P1(vehicle+1:end)];
F1=assign(1,:);
Z=assign(2,:);
F2=assign(3,:);


%% ���ʱ���·��
%% �����㵽�����λ1
RC=zeros(length(F1),20);
Rc_Ca=[];
for k=1:length(F1)
    t=F1(k)+2;
    if k<=3;
        s=1;
        [Ca,R_c]=Tree_building(s,tij1,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
    elseif k>3&&k<=6
        s=1;
        [Ca,R_c]=Tree_building(s,tij2,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
    elseif k>6&&k<=12
        s=1;
        [Ca,R_c]=Tree_building(s,tij3,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
     elseif k>12&&k<=15
        s=2;
        [Ca,R_c]=Tree_building(s,tij1,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
      elseif k>15&&k<=18  
        s=2;
        [Ca,R_c]=Tree_building(s,tij2,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
    else
        s=2;
        [Ca,R_c]=Tree_building(s,tij3,t);
%         for i=1:length(R_c)
%             R_c(i)=data(R_c(i),1);
%         end
        RC(k,1:length(R_c))=R_c;
        Rc_Ca=[Rc_Ca;Ca];
    end
end
%% �ӷ����λ1��ת�ص�
RC2=zeros(length(F1),20);
for i=1:vehicle
   temp_RC=RC(i,:);
   temp_RC(find(temp_RC==0))=[];
   s=temp_RC(end);
   t=Z_24(i)+124;
   if i<=3 || (i<=15&&i>=13)
        [Ca,R_c]=Tree_building(s,tij1_Z,t);
        RC2(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca+0.17;
   end
   if (i>=4&&i<=6)|| (i>=16 &&i<=18)
        [Ca,R_c]=Tree_building(s,tij2_Z,t);
        RC2(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca+0.17;
   end
   if (i>=7&&i<=12)|| (i>=19 &&i<=24)
        [Ca,R_c]=Tree_building(s,tij3_Z,t);
        RC2(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca+0.17;
   end
end
%% ��ת�ص㵽�����Ϊ2
RC3=zeros(length(F1),20);
for i=1:vehicle
   temp_RC=RC2(i,:);
   temp_RC(find(temp_RC==0))=[];
   s=temp_RC(end);
   t=F2(i)+2;
   if i<=3 || (i<=15&&i>=13)
        [Ca,R_c]=Tree_building(s,tij1_Z,t);
        RC3(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca;
   end
   if (i>=4&&i<=6)|| (i>=16 &&i<=18)
        [Ca,R_c]=Tree_building(s,tij2_Z,t);
        RC3(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca;
   end
   if (i>=7&&i<=12)|| (i>=19 &&i<=24)
        [Ca,R_c]=Tree_building(s,tij3_Z,t);
        RC3(i,1:length(R_c))=R_c;
        Rc_Ca(i)=Rc_Ca(i)+Ca;
   end
end
Route=zeros(vehicle,50);
for i=1:vehicle
    temp_RC=RC(i,:);
    temp_RC(find(temp_RC==0))=[];
    temp_RC=data(temp_RC,1)';
    temp_RC2=RC2(i,:);
    temp_RC2(find(temp_RC2==0))=[];
    temp_RC2(1)=[];
    temp_RC2=data(temp_RC2,1)';
    temp_RC3=RC3(i,:);
    temp_RC3(find(temp_RC3==0))=[];
    temp_RC3(1)=[];
    temp_RC3=data(temp_RC3,1)';
    Route(i,1:length(temp_RC)+length(temp_RC2)+length(temp_RC3))=[temp_RC,temp_RC2,temp_RC3];
end
fitness=max(Rc_Ca)-min(Rc_Ca);
end