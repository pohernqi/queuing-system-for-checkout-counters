function y = ServiceTime(counterService, counterRange, rand)
    
    a = 1;
    b = 0;
    for i = 1:size(counterService,2)
        b = counterRange(i);
        if (rand >= a && rand <= b)
            y = counterService(i);
            break;
        end;
        a = 1 + b;
    end
    
    
    