function box_i=find_box(t1,Re_i,epsilon)
load data
temp_consum_eng=consum_eng(t1:t1+59);
if temp_consum_eng(end)~=0
    T_max=59;
else
    temp_consum_eng(find(temp_consum_eng==0))=[];
    T_max=length(temp_consum_eng)-1;
end
%% ѡ�������ӵ����
sbwm=zeros(T_max+1,6);%������ʱ������
dbwm=zeros(T_max+1,6);%����ƫ��
mt1=inf*ones(1,6);
for i=sig
    if (sum(consum_eng(t1:t1+T_max))<=Re_i(i))&& prod(consum_eng(t1:t1+T_max)<=U_i(i))%�жϹ������Ƿ�С��ʣ������
        sbwm(:,i)=consum_eng(t1:t1+T_max);
        temp_Re_i=Re_i;
        for t=1:T_max+1
            temp_Re_i(i)=temp_Re_i(i)-sbwm(t,i);
            [x,y,z] = oCenter(temp_Re_i);
            dbwm(t,i)=Deviation([x,y,z] ,t1+t-1);
        end
        mt1(i)=max(dbwm(:,i));
    end
end
[value1,min_1]=min(mt1);

%% ѡ�������ӵ����
mnhm=inf*ones(T_max+1,length(dou));%����ƫ��
mt2=inf*ones(1,length(dou));
for i=1:length(dou)
    if (ismember(1,dou(i,1))&& ismember(2,dou(i,2)))|| (ismember(6,dou(i,1))&& ismember(5,dou(i,2)))%1��2����,2������������
        if (sum(consum_eng(t1:t1+T_max))<=Re_i(dou(i,1)))&& prod(consum_eng(t1:t1+T_max)<=U_i(dou(i,1)))&& prod(consum_eng(t1:t1+T_max)<=U_i(dou(i,2)))
            temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(dou(i,1))=temp_Re_i(dou(i,1))-sbwm(t,2);
                [x,y,z] = oCenter(temp_Re_i);
                mnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end                
        end
    elseif (ismember(1,dou(i,1))&& ~ismember(2,dou(i,2)))|| (ismember(6,dou(i,1))&& ~ismember(5,dou(i,2)))%1��2����,2��������������
        if (epsilon*60<=Re_i(dou(i,1)))&&(sum(consum_eng(t1:t1+T_max))<=Re_i(dou(i,2)))&& prod(consum_eng(t1:t1+T_max)<=U_i(dou(i,2)))
            temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(dou(i,1))=temp_Re_i(dou(i,1))-epsilon;
                if dou(i,1)==1
                    temp_Re_i(2)=temp_Re_i(2)+epsilon;
                else
                    temp_Re_i(5)=temp_Re_i(5)+epsilon;
                end
                temp_Re_i(dou(i,2))=temp_Re_i(dou(i,2))-sbwm(t,2);
                [x,y,z] = oCenter(temp_Re_i);
                mnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end  
        end
    else
        if (0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(dou(i,1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(dou(i,2)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(dou(i,1)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(dou(i,1)))
            temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(dou(i,1))=temp_Re_i(dou(i,1))-0.5*sbwm(t,2);
                temp_Re_i(dou(i,2))=temp_Re_i(dou(i,2))-0.5*sbwm(t,2);
                [x,y,z] = oCenter(temp_Re_i);
                mnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    end
    mt2(i)=max(mnhm(:,i));
end
[value2,min_2]=min(mt2);
min_2=dou(min_2,:);


%% ѡ�������ӵ����
dmnhm=inf*ones(T_max+1,length(tri));%����ƫ��
mt3=inf*ones(1,length(tri));
for i=1:length(tri)
    if (ismember(tri(i,2),[2,5]))&&(ismember(tri(i,3),[1,6]))%��һ�����Ӹ��ڶ������ӹ��ͣ��ڶ��������򷢶������ͣ��������������������ӹ��ͣ����Ǹ����Ӳ�����
        if (sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,1)))&& prod(consum_eng(t1:t1+T_max)<=U_i(tri(i,1)))&& (epsilon*60<=Re_i(tri(i,3)))
            temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(tri(i,1))=temp_Re_i(tri(i,1))-sbwm(t,2);
                temp_Re_i(tri(i,3))=temp_Re_i(tri(i,3))-epsilon;
                if tri(i,3)==1
                    temp_Re_i(2)=temp_Re_i(2)+epsilon;
                else
                    temp_Re_i(5)=temp_Re_i(5)+epsilon;
                end
                [x,y,z] = oCenter(temp_Re_i);
                dmnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    elseif (ismember(tri(i,2),[2,5]))&&~(ismember(tri(i,3),[1,6]))
        if (0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,3)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(tri(i,1)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(tri(i,3)))
           temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(tri(i,1))=temp_Re_i(tri(i,1))-0.5*sbwm(t,2);
                temp_Re_i(tri(i,3))=temp_Re_i(tri(i,3))-0.5*sbwm(t,2);
                [x,y,z] = oCenter(temp_Re_i);
                dmnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    elseif ~(ismember(tri(i,2),[2,5]))&&~(ismember(tri(i,3),[1,6]))
        if (epsilon*60<=Re_i(tri(i,1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,2)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,3)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(tri(i,2)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(tri(i,3)))
           temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(tri(i,2))=temp_Re_i(tri(i,2))-0.5*sbwm(t,2);
                temp_Re_i(tri(i,3))=temp_Re_i(tri(i,3))-0.5*sbwm(t,2);
                temp_Re_i(tri(i,1))=temp_Re_i(tri(i,1))-epsilon;
                if tri(i,1)==1
                    temp_Re_i(2)=temp_Re_i(2)+epsilon;
                else
                    temp_Re_i(5)=temp_Re_i(5)+epsilon;
                end
                [x,y,z] = oCenter(temp_Re_i);
                dmnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    else
        if  (sum(consum_eng(t1:t1+T_max))<=Re_i(tri(i,2)))&& prod(consum_eng(t1:t1+T_max)<=U_i(tri(i,2)))&& (epsilon*60<=Re_i(tri(i,1))) && (epsilon*60<=Re_i(tri(i,3)))
            temp_Re_i=Re_i;
            for t=1:T_max+1
                temp_Re_i(tri(i,1))=temp_Re_i(tri(i,1))-epsilon;
                temp_Re_i(tri(i,3))=temp_Re_i(tri(i,3))-epsilon;
                temp_Re_i(2)=temp_Re_i(2)+epsilon;
                temp_Re_i(5)=temp_Re_i(5)+epsilon;
                temp_Re_i(tri(i,2))=temp_Re_i(tri(i,2))-sbwm(t,2);
                [x,y,z] = oCenter(temp_Re_i);
                dmnhm(t,i)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    end
    mt3(i)=max(dmnhm(:,i));
end
[value3,min_3]=min(mt3);
min_3=tri(min_3,:);

%% �ҵ�ǰ60s̰�Ĳ�����Сֵ
a=[value1,value2,value3];
[~,idx]=min(a);
if idx==1
    box_i=min_1;
elseif idx==2
    box_i=min_2;
else
    box_i=min_3;
end
end

