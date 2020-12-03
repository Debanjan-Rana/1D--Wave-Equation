clc
clear all

xi=0;    %initial x value
xf=4*pi;  %final x value

r=0.2;    %r is constant which is defined in attached pdf
n=50;     % total number of nodes
dx=(xf-xi)/(n-1);  %increament along x
dt=0.1;             %increament along time
tf=30               %final time

A1=zeros(n);        %matrix for n=0
A2=zeros(n);        %matrix for n>=1
for i=1:n
    %creating A1 and A2 matrices
    A1(i,i)=1+r;
    A2(i,i)=1+2*r;
    if i==1
        A2(i,i+1)=-r;
        A1(i,1+i)=-0.5*r;
    elseif i==n
        A1(i,i-1)=-0.5*r;
        A2(i,i-1)=-r;
    else
         A2(i,i+1)=-r;
        A1(i,1+i)=-0.5*r;
         A1(i,i-1)=-0.5*r;
        A2(i,i-1)=-r;
    end
end

for i=1:n
    u(i,1)=0;       %assigning the values of with 0 u is represented phi in report
end

count=2;

for t=1:dt:tf
    %solving for u value using GaussSeidel
    if t==1
        for i=1:n
            B1(i,1)=sin((xi+i*dx)*pi*count/xf);
        end
        [u(:,count)]=GaussSiedel(A1,B1(:,1),n);
        u(1,count)=0;           %boundary condition at x=0
        u(n,count)=0;           %boundary consition at x=L
    else
        for i=1:n
            B2(i,1)=2*u(i,count-1)-u(i,count-2);
        end
         [u(:,count)]=GaussSiedel(A2,B2(:,1),n);
        u(1,count)=0;
        u(n,count)=0;
    end
    count=count+1;
end
x=[xi:dx:xf]
count=1;

%code for video and plot
 myVideo=VideoWriter('OneD_Wave');
 myVideo.FrameRate = 10;
 open(myVideo)

for t=1:dt:tf
    hold on
    axis manual
    axis([xi xf -20 20])
    plot(x',u(:,count))  
       
    xlabel('x value')
    ylabel(' Wave Function')
 title( sprintf('t = %.1f', t) );

    count=count+1;
    pause(0.1)
   frame = getframe(gcf);
  writeVideo(myVideo,frame);

    clf
end
close(myVideo)