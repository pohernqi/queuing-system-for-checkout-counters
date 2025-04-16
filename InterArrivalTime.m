function y = InterArrivalTime(arrivalTime, arrivalRange, rand)
    
    a = 1;
    b = 0;
    for i = 1:size(arrivalTime,2)
        b = arrivalRange(i);
        if (rand >= a && rand <= b)
            y = arrivalTime(i);
            break;
        end;
        a = 1 + b;
    end
    
    
    