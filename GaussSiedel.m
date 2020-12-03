function [x0] = GaussSiedel(A,B,n)

D=zeros(n);
L=zeros(n);
U=zeros(n);
for j=1:n
    for i=1:n
        if(j>i)
            U(i,j)=A(i,j);
        elseif (j<i)
            L(i,j)=A(i,j);
        else
            D(i,j)=A(i,j);
        end
    end
end



 x0=B;

 E=-(D+L)^(-1)*U;
 F=(D+L)^(-1)*B;

 for i=1:10000
     x1=(E*x0)+F;
     Xn=A*x1-B;
     
         for j= 1:n
         Xe(i,j)=abs((x1(j,1)-x0(j,1))/x1(j,1))*100;
         end
         
         
      AB(i,1)=norm(Xn); %Calculates the norm i.e. the value of error
      k(i,1)=i;
     if(AB(i,1)<10^(-12))
         i
         break;
     end
     x0=x1;
 end

end

