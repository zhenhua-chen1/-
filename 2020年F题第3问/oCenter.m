function [x,y,z] = oCenter(Re_i2)
load data
Re_i=Re_i2;
V_oil=Re_i/rho;%�������
h_oil=V_oil./(size_i(:,1).*size_i(:,2));%���͵ĸ߶�
z=pos_i(:,3)-(size_i(:,3)/2-h_oil/2);%�������������
z=z'*Re_i/sum(Re_i);%�������z������
x=pos_i(:,1)'*Re_i/(sum(Re_i)+3000);%�������x������
y=pos_i(:,2)'*Re_i/(sum(Re_i)+3000);;%�������y������
end

