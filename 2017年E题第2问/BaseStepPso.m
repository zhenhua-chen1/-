%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������Ⱥ�㷨�ĵ�������λ��,�ٶȵ��㷨����
function [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,a,c1,c2,LoopCount,CurCount,M,infinN)

if nargin~=12  %�����ݴ�
    error('����Ⱥ����������Ĳ�����������')
end
if nargout~=2  %����ݴ�
    error('����Ⱥ����������ĸ���̫�٣����ܱ�֤ѭ��������')
end


%*********************************************
%*****��������Ĵ��룬���Ը��Ĺ������ӵı仯*****
%---------------------------------------------------------------------
%���εݼ�����

w=MaxW-CurCount*((MaxW-MinW)/LoopCount);

[ParRow,ParCol]=size(ParSwarm);

%�õ����ӵ�ά��
ParCol=(ParCol-1)/2;
SubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%������ʷ����ֵ�뵱ǰλ�õĲ�ֵ


for row=1:ParRow
    SubTract2=OptSwarm(ParRow+1,:)-ParSwarm(row,1:ParCol);%�����ȫ������ֵ�뵱ǰ������λ�õĲ�ֵ
    %�ٶȸ��¹�ʽ
    TempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*SubTract1(row,:)+c2*unifrnd(0,1).*SubTract2;
    %�����ٶȵĴ���
    for h=1:ParCol
        if TempV(:,h)>ParticleScope(h,2)
            TempV(:,h)=ParticleScope(h,2);
        end
        if TempV(:,h)<-ParticleScope(h,2)
            TempV(:,h)=-ParticleScope(h,2)+1e-10;%��1e-10��ֹ��Ӧ�Ⱥ��������
        end
    end
    %���¸������ٶ�ֵ
    ParSwarm(row,ParCol+1:2*ParCol)=TempV;
     %---------------------------------------------------------------------
    
    TempPos=ParSwarm(row,1:ParCol)+a*TempV;
    %����λ�÷�Χ�Ĵ���
    for h=1:ParCol
        if TempPos(:,h)>ParticleScope(h,2)
            TempPos(:,h)=ParticleScope(h,2);
        end
        if TempPos(:,h)<=ParticleScope(h,1)
            TempPos(:,h)=ParticleScope(h,1)+1e-10;%��1e-10��ֹ��Ӧ�Ⱥ��������
        end
    end
    %���¸�����λ��ֵ
    ParSwarm(row,1:ParCol)=TempPos;
    
    %����ÿ�����ӵ��µ���Ӧ��ֵ
%     [container_num]=decoding(ParSwarm(k,1:ParticleSize));
%     ParSwarm(k,2*ParticleSize+1)=AdaptFunc(container_num);%����ÿ�����ӵ���Ӧ��ֵ
    
    [RC,RC_Ca]=decoding(ParSwarm(row,1:ParCol));
    ParSwarm(row,2*ParCol+1)=RC_Ca;
    
    [RC,RC_Ca]=decoding(OptSwarm(row,1:ParCol));
    if ParSwarm(row,2*ParCol+1)>RC_Ca
        OptSwarm(row,1:ParCol)=ParSwarm(row,1:ParCol);
    end
end
%forѭ������
%Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)������ȫ������ֵ�ĸı� 
[maxValue,row]=min(ParSwarm(:,2*ParCol+1));

[RC,RC_Ca]=decoding(ParSwarm(row,1:ParCol));
YResult=RC_Ca;
[RC,RC_Ca]=decoding(OptSwarm(ParRow+1,:));
Y0Result=RC_Ca;

%if AdaptFunc(ParSwarm(row,1:ParCol))>AdaptFunc(OptSwarm(ParRow+1,:))
if YResult>Y0Result
    OptSwarm(ParRow+1,:)=ParSwarm(row,1:ParCol);
end
