function y=LCG(n,min,max)
    %X=(a*x +c)(mod m)
    
   a=11;
   c=29;
   x=rand()*max;
   x=ceil(x); 
    
   for i=1:n
        z=a*x+c;
      y(i)=(ceil(mod(z,max+1)));
        
      if y(i) < min
           y(i)=y(i)+min;
        end
        x=y(i);
    end