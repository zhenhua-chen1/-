function [Ca,R_c]=Dijkstra_apprach(cij,s,t)
%% step0��start
n=size(cij,1);%ȷ���ڵ����;
a=ones(n,n);%ȷ����ž���;
L=struct('cij',a,'eij',a);%��żĴ�;
L.cij=cij;%����ȼ��ϵ��
n=size(cij,1);%ȷ���ڵ����;
path_c=zeros(n,n);%����·��ѡ��;

%% ȷ���ɴ�·��
for i=1:n
    for j=1:n
        if cij(i,j)~=100000;
            path_c(i,j)=j; %ȷ���ɴ�·��;
        end
    end
end

%% step1��find least cost node;
for k=1:n
    for i=1:n
        for j=1:n
            if L.cij(i,k)+cij(k,j)<L.cij(i,j)
                L.cij(i,j)=L.cij(i,k)+cij(k,j); % calculate cost to each;
                path_c(i,j)=path_c(i,k);   %save;
            end
        end
    end
end

%% step2:update


%% output the pair of OD;
Ca=zeros(0,0);
R_c=s;
while 1
    if s==t  %���ÿ��·��ѡ������·��;
        Ca=fliplr(Ca);
        Ca=[0,Ca];%���ÿ��ȼ��·��ѡ������·��;
        return
    end
    Ca=[Ca,L.cij(s,t)]
    R_c=[R_c,path_c(s,t)];
    s=path_c(s,t);
end
end