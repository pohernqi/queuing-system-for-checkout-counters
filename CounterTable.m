function y = CounterTable(counterService, counterRange)
    
    for counter = 1:numel(counterService)
        prob = 0;
        rangeStart = 1;
        if (counter < 4)
            disp(['Counter ', num2str(counter), ' (Normal)']);
        else
            disp(['Counter ', num2str(counter), ' (Express)']);
        end;
        disp('-----------------------------------------------');
        disp('| Service Time | Probability | CDF  |  Range  |');
        disp('-----------------------------------------------');
        
        for i=1:numel(counterService{counter}) 
            if (i == 1)
                prob = counterRange{counter}(i)/100;
            else
                prob = counterRange{counter}(i)/100 - counterRange{counter}(i-1)/100;
            end;
            fprintf('|       %d      |    %.2f     | %.2f | %2d - %-3d|\n', [counterService{counter}(i), prob, counterRange{counter}(i)/100, rangeStart, counterRange{counter}(i)]);
            rangeStart = 1 + counterRange{counter}(i);
        end
        disp('-----------------------------------------------');
        disp(' ');
    end