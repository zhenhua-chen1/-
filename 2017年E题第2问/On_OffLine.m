
%������������������
function On_OffLine(LoopCount,MeanAdapt,IsPlot)
for k=1:LoopCount
    OnLine(1,k)=sum(MeanAdapt(1,1:k))/k;%��ȡ�������ܵ�����
    OffLine(1,k)=min(MeanAdapt(1,1:k)); 
end

for k=1:LoopCount
    OffLine(1,k)=sum(OffLine(1,1:k))/k;%��ȡ�������ܵ�����
end

%��������������������������
%subplot(m,n,p);%��ͼ�δ��ڷֳ�m��n�е��Ӵ��ڣ����Ϊp���Ӵ���Ϊ��ǰ����
if 1==IsPlot
    subplot(1,2,1);
    %figure
    hold on
    title('������������ͼ')
    xlabel('��������');
    ylabel('��������');
    grid on
    plot(OffLine);

    subplot(1,2,2);
    %figure
    hold on
    title('������������ͼ')
    xlabel('��������');
    ylabel('��������');
    grid on
    plot(OnLine);
end
