function y=RUD(n,min,max)
    % X=a+(b-a)R
    
    r=rand(1,n);
    k=min+(max-min)*r;
    y=ceil(k);
