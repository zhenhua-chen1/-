function [c,po,e_h,e_a,e_h_1,e_a_1,prob_e]=Dijkstra_2(o,Ca)
load data
node=length(Ca);% �ܽ����;
e_h=zeros(1,node);% ��ֱ���;
e_a=zeros(1,node);% ˮƽ���;
e_h_1=zeros(1,node-1);% У��ǰ��ֱ���;
e_a_1=zeros(1,node-1);% У��ǰˮƽ���;
prob_e=ones(1,node-1);% �õ��Ƿ������ɹ�;
c=1000000000000000000*ones(1,node);% ѡ�� c(o,n) ʱ ��;
c(1,o)=0;% ѡ�� c(o,o) ʱ 0;
nodeactive(1,node)=0;%ѡ��ڵ�n�ǷǱ�ǵ�;
nodeactive(1,o)=1;%ѡ��ڵ�n�Ǳ�ǵ�;
po=zeros(1,node);% ѡ��ڵ�n��backnode;
while 1
    pos=find(nodeactive==1)';
    least_cost=[c(pos)',pos];
    [~,n]=min(least_cost(:,1));
    n=least_cost(n,2);  %ѡ��һ����Сֵ��;
        for m=1:node
            if m~=node && m~=1
                if ess(m-1)==1 %�ж����ĸ�������
                    if prob(m-1)==1&& rand>mp %�жϴ�ֱУ���Ƿ�ɹ�
                            if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=alhpa_1)&&(e_a(n)+Delta*Ca(n,m)<=alhpa_2))
                                c(m)=c(n)+Ca(n,m); %���³ɱ�;
                                e_h(m)=e_h(n)+Delta*Ca(n,m);
                                e_h(m)=min(5,e_h(m));
                                prob_e(m)=0;%У��ʧ��
                                e_a(m)=e_a(n)+Delta*Ca(n,m);% ����ˮƽ���;
                                e_a_1(m-1)=e_a(m);%У�����ˮƽ���
                                po(m)=n;   %(backnode of m);
                                nodeactive(m)=1;
                            end         
                    else
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=alhpa_1)&&(e_a(n)+Delta*Ca(n,m)<=alhpa_2))
                            c(m)=c(n)+Ca(n,m); %���³ɱ�;
                            e_h(m)=0;
                            e_a(m)=e_a(n)+Delta*Ca(n,m);% ����ˮƽ���;
                            e_a_1(m-1)=e_a(m);%У�����ˮƽ���
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end
                    end
                else
                    if prob(m-1)==1&& rand>mp %�ж�ˮƽУ���Ƿ�ɹ�
                            if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=Beta_1)&&(e_a(n)+Delta*Ca(n,m)<=Beta_2))
                                c(m)=c(n)+Ca(n,m); %���³ɱ�;
                                e_a(m)=e_a(n)+Delta*Ca(n,m);
                                e_a(m)=min(5,e_a(m));
                                prob_e(m)=0;%У��ʧ��
                                e_h(m)=e_h(n)+Delta*Ca(n,m);% ����ˮƽ���;
                                e_h_1(m-1)=e_h(m);%У�����ˮƽ���
                                po(m)=n;   %(backnode of m);
                                nodeactive(m)=1;
                            end 
                    else
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=Beta_1)&&(e_a(n)+Delta*Ca(n,m)<=Beta_2))
                            c(m)=c(n)+Ca(n,m); %���³ɱ�;
                            e_a(m)=0;
                            e_h(m)=e_h(n)+Delta*Ca(n,m);% ���Ӵ�ֱ���;
                             e_h_1(m-1)=e_h(m);%У��ǰ�Ĵ�ֱ���
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end  
                    end
                end
            elseif  m==node
                if(c(n)+Ca(n,m)<c(m))&&(e_h(n)+Delta*Ca(n,m)<theta)&&((e_a(n)+Delta*Ca(n,m)<theta))
                    c(m)=c(n)+Ca(n,m); %���³ɱ�;
                    e_a(m)=e_a(n)+Delta*Ca(n,m);
                    e_h(m)=e_h(n)+Delta*Ca(n,m);
                    e_a_1(m-1)=e_a(m);
                    e_h_1(m-1)=e_h(m);
                    po(m)=n;   %(backnode of m);
                end
            end  
        end
        nodeactive(n)=0 ;% ѡ��ڵ�n�ǷǱ�ǵ�;
    if nodeactive==0;
        break
    end
 end    
end
