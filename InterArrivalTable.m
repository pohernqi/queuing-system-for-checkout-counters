function y = InterArrivalTable(arrivalTime, arrivalRange)
    prob = 0;
    rangeStart = 1;
    disp('Inter-arrival Time')
    disp('-----------------------------------------------------');
    disp('| Inter-arrival Time | Probability | CDF  |  Range  |');
    disp('-----------------------------------------------------');
    for i=1:size(arrivalTime,2)
        if (i == 1)
            prob = arrivalRange(i)/100;
        else
            prob = arrivalRange(i)/100 - arrivalRange(i-1)/100;
        end;
        fprintf('|         %d          |    %.2f     | %.2f | %2d - %-3d|\n', [arrivalTime(i), prob, arrivalRange(i)/100, rangeStart, arrivalRange(i)]);
        rangeStart = 1 + arrivalRange(i);
    end
    disp('-----------------------------------------------------');