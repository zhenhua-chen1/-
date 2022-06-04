function [ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope,M,infinN)

if nargin~=5
    error('����Ⱥ��ʼ��������Ĳ�����������')
end
if nargout<2
    error('����Ⱥ��ʼ��������Ĳ����ĸ���̫�٣����ܱ�֤�Ժ�����С�');
end

[row,colum]=size(ParticleSize);
if row>1||colum>1
    error('����Ⱥ��ʼ������������ӵ�ά��������һ��1��1�е����ݡ�');
end
[row,colum]=size(ParticleScope);
if row~=ParticleSize||colum~=2
    error('����Ⱥ��ʼ������������ӵ�ά����Χ����');
end

%��ʼ������Ⱥ����
%��ʼ������Ⱥ����ȫ����Ϊ[0-1]�����
%rand('state',0);
% a1=randperm(60);
% a2=randperm(60);
ParSwarm=rand(SwarmSize,2*ParticleSize+1);%��ʼ��λ�� �ٶ� ��ʷ�Ż�ֵ

%������Ⱥ��λ��,�ٶȵķ�Χ���е���
for k=1:ParticleSize
    ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);%�����ٶȣ�ʹ�ٶ���λ�õķ�Χһ��
    ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
end

%��ÿһ�����Ӽ�������Ӧ�Ⱥ�����ֵ
for k=1:SwarmSize
    [RC,RC_Ca]=decoding(ParSwarm(k,1:ParticleSize));
    ParSwarm(k,2*ParticleSize+1)=RC_Ca;%����ÿ�����ӵ���Ӧ��ֵ
end

%��ʼ������Ⱥ���Ž����
OptSwarm=zeros(SwarmSize+1,ParticleSize);
%����Ⱥ���Ž����ȫ����Ϊ��
[maxValue,row]=min(ParSwarm(:,2*ParticleSize+1));
%Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)
OptSwarm=ParSwarm(1:SwarmSize,1:ParticleSize);
OptSwarm(SwarmSize+1,:)=ParSwarm(row,1:ParticleSize);%����Ӧ��ֵ�������ӵ�λ����Ϊȫ�����ӵ�����ֵ


