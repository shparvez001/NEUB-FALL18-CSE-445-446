close all
clear all
clc

%Walsh code generator
n=8;
l=log2(n);
main=[-1];
invert=-1.*main;

for i=1:l
    main=[main, main; main, invert];
    invert=-1.*main;
end
walshCode=main;
antipodal=invert;
for i=1:n
    for j=1:n
        if walshCode(i,j)==-1
            walshCode(i,j)=0;
        end
        
        if antipodal(i,j)==-1
            antipodal(i,j)=0;
        end
    end
end
%How to call a walsh code
%walshCode(i,:)
%where i= code number i.e. 1,2,3,4

%For calling the matrix with 0 replaced by -1 ie bipolar NRZ call the
%following
%main(i,:)
%where i= code number i.e. 1,2,3,4

%walsh Code ends

disp('Give data for user 1 and 2 in same length in vector form');

%USer data begins here
d1=input('Data for user 1: ');
d2=input('Data for user 2: ');

%user1 Data
disp('User 1 Data');
%d1 =[1 0 1 1];        
disp(d1); 
length1=length(d1);

%user2 Data
disp('User 2 Data');
%d2 =[1 0 0 1];        
disp(d2); 
length2=length(d2);

figure()                        %  figure for DATA for user 1
subplot(311);
stem(d1);
axis([0 length1+1 -1.5 1.5]);
title('\bf orignal data form user no. 1');
grid on;


for i=1:length1
    if d1(i)==0         %  NRZ conversion for DATA of user 1     
        d1(i)=-1;
    end
end
disp('data user 1 in NRZ :-');
disp(d1);                %  disply NRZ DATA for user 1
subplot(312);                  %  figure for NRZ DATA for user 1
stem(d1);
axis([0 length1+1 -1.5 1.5]);
title('\bf orignal data from user no. 1 in NRZ Format');
grid on;

code1=main(3,:);
disp(code1);                %  disply NRZ DATA for user 1
subplot(313);                  %  figure for NRZ DATA for user 1
stem(code1);
title('\bf code user no. 1 in NRZ Format');
grid on;


figure()                        %  figure for DATA for user 2
subplot(311);
stem(d2);
axis([0 length2+1 -1.5 1.5]);
title('\bf orignal data form user no. 2');
grid on;


for i=1:length2
    if d2(i)==0         %  NRZ conversion for DATA of user 2     
        d2(i)=-1;
    end
end
disp('data user 2 in NRZ :-');
disp(d2);                %  disply NRZ DATA for user 2
subplot(312);                  %  figure for NRZ DATA for user 2
stem(d2);
axis([0 length2+1 -1.5 1.5]);
title('\bf orignal data from user no. 2 in NRZ Format');
grid on;

code2=main(7,:);
disp(code2);                %  disply NRZ DATA for user 1
subplot(313);                  %  figure for NRZ DATA for user 1
stem(code2);
title('\bf code user no. 2 in NRZ Format');
grid on;


%Spreading begins here

figure();
disp('Spread data for user 1')
tx1=[];
for i=1:length1
    tx1=[tx1 d1(i)*code1];
end

disp(tx1)
subplot(311);                 
stem(tx1);
title('\bf User 1 spreaded data');
grid on;


disp('Spread data for user 2')
tx2=[];
for i=1:length2
    tx2=[tx2 d2(i)*code2];
end

disp(tx2)
subplot(312);               
stem(tx2);
title('\bf User 2 spreaded data');
grid on;

disp('Data For transmission')
tx=tx1+tx2;
disp(tx2);

subplot(313);                 
stem(tx);
title('\bf Data for transmission');
grid on;
%Spreading ends

rx=tx;


%Despreading begins here
figure();
pnmatrix1=[];
for i=1:length1
    pnmatrix1=[pnmatrix1 code1];
end

pnmatrix2=[];
for i=1:length2
    pnmatrix2=[pnmatrix2 code2];
end


% pnmatrix1=[code1 code1 code1 code1];
% pnmatrix2=[code2 code2 code2 code2];

rx1=rx.*pnmatrix1;
rx2=rx.*pnmatrix2;

subplot(221)
stem(rx1)
title('\bf RX1');

%recovering data for user 1
recovered1=[];
for i=0:length1-1
    testvector=rx1(n*i+1:n*i+8);
    if sum(testvector)>0
        recovered1=[recovered1 1];
    else
        recovered1=[recovered1 0];
    end
end
disp('Recovered data from user 1')
disp(recovered1)

subplot(222)
stem(recovered1)
axis([0 length1+1 -1.5 1.5]);
title('\bf Recovered data from user 1');

%Despreading of user 2
subplot(223)
stem(rx2)
title('\bf RX2');

%recovering data for user 2
recovered2=[];
for i=0:length2-1
    testvector=rx2(n*i+1:n*i+8);
    if sum(testvector)>0
        recovered2=[recovered2 1];
    else
        recovered2=[recovered2 0];
    end
end
disp('Recovered data from user 2')
disp(recovered2)
subplot(224)
stem(recovered2)
axis([0 length2+1 -1.5 1.5]);
title('\bf Recovered data from user 2');
