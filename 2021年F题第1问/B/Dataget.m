function Dataget()

dataB_Crew=readtable('�����Ű�Data B-Crew.csv');
dataB_Flight=readtable('�����Ű�Data B-Flight.xlsx');



%% ����������������б�������

DptrTime1 = dataB_Flight{:,12};
DptrStn1 = dataB_Flight{:,4};
ArrvTime1 = dataB_Flight{:,16};
ArrvStn1 = dataB_Flight{:,7};
DptrDay = dataB_Flight{:,10};
ArrvDay = dataB_Flight{:,14};
% VarName12 =dataA_Flight{:,6};
% VarName13 = dataA_Flight{:,7};
% VarName15 = dataA_Flight{:,9};
% VarName16 = dataA_Flight{:,10};
FltNum2 = dataB_Flight{:,17};
% ����Ҫ����������(datenum)����������ʱ��Ĵ��룬��ȡ��ע�������У��Ա��� datenum ��ʽ���ص�������ڡ�

% DptrDate3=datenum(DptrDate3);
% ArrvDate3=datenum(ArrvDate3);
%FLI=[FltNum2,VarName13,DptrStn1,VarName16,ArrvStn1];
base=[241,242];%����
Dptr_I1=find(DptrStn1==base(1));
Arrv_I1=find(ArrvStn1==base(1));
Dptr_I2=find(DptrStn1==base(2));
Arrv_I2=find(ArrvStn1==base(2));
I=length(FltNum2);
Rho=zeros(I,I);
for i1=1:I
    for i2=1:I
        if i1<i2
            if ArrvStn1(i1)==DptrStn1(i2) && (DptrTime1(i2)-ArrvTime1(i1))>=40/(24*60)
                Rho(i1,i2)=1;
            end
        end
    end
end
people=height(dataB_Crew);
MaxBlk=600;%һ��ִ�ڷ���ʱ��
MinRest=660;%��Ϣʱ��
MaxDP=720;%ִ��ʱ��
save data
end