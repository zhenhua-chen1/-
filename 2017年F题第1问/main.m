clc
clear 
close all
tic
disp('��ȡ����')
% DataGet()
load data
PSwarmSize=10;%��Ⱥ��ģ
PSize=24;%��С
IterMax=10;%��������
IsDraw=1;%�Ƿ�ͼ
IsStep=0;%�Ƿ�һ��������
IsPlot=1;
[MaxW,MinW,a,c1,c2,M,D,infinN]=ConstantParameter;%���ó���
%��ʼ����Ⱥ
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end      
 
[row,colum]=size(ParticleScope);
if row~=PSize||colum~=2
    error('��������ӵ�ά����Χ����');
end
ParticleScope=zeros(PSize,2);
 for h=1:PSize
        ParticleScope(h,2)=D;
        ParticleScope(h,1)=-D;
 end
[ParSwarm,OptSwarm]=InitSwarm(PSwarmSize,PSize,ParticleScope,M,infinN);
 drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
%��ʼ�����㷨�ĵ���
for k=1:IterMax
    %��ʾ�����Ĵ�����
    disp('----------------------------------------------------------')
    TempStr=sprintf('�� %g �ε���',k);
    disp(TempStr);
    disp('----------------------------------------------------------')
    
    %����һ���������㷨
    %[ParSwarm,OptSwarm]=StepFindFunc(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,0.95,0.4,IterMax,k);
    [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,a,c1,c2,IterMax,k,M,infinN);
    
    %��Ŀ�꺯����ͼ���ϻ���2ά���µ����ӵ���λ��
    drawParticle(PSwarmSize,ParSwarm,PSize,IsDraw);
    
    XResult=OptSwarm(PSwarmSize+1,1:PSize);%��ȡ���ε����õ���ȫ������ֵ
    [RC,RC_Ca]=decoding(XResult);
    YResult=RC_Ca;%����ȫ������ֵ��Ӧ�����ӵ���Ӧ��ֵ               
    if IsStep~=0
        %XResult=OptSwarm(PSwarmSize+1,1:PSize);
        %YResult=AdaptFunc(XResult);
        str=sprintf('%g ������������Ŀ�꺯��ֵ %g',k,YResult);
        disp(str);
        disp('�´ε����������������');
        pause
    end
    
    %��¼ÿһ����ƽ����Ӧ��
    MeanAdapt(1,k)=mean(ParSwarm(:,2*PSize+1));%mean����Ϊȡ��Чֵ����
end
%forѭ��������־

%��¼��С������ƽ����Ӧ��
MinMaxMeanAdapt=[min(MeanAdapt),max(MeanAdapt)];

%������������������
On_OffLine(IterMax,MeanAdapt,IsPlot);
%��¼���ε����õ�������ֵ ��Ӧ��ֵ
XResult=OptSwarm(PSwarmSize+1,1:PSize);
[RC,RC_Ca,Rc_CaK]=decoding(XResult);
YResult=Rc_CaK;
Result={};
Result=[Result,RC,YResult,MinMaxMeanAdapt];

%% ���
path=numtostr(Result{1,1});%ת���ַ������
for k=1:PSize
    disp(['��',num2str(k),'������·��Ϊ��',path{k}])
    disp(['�䵽��ʱ��Ϊ��',num2str(YResult(k))])
end
