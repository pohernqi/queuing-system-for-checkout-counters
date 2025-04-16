function y = PrintMessage(NumCustomer, counternumber, arrivalTime, queueCounter, departureTime, serviceStart,noOfItems)
    %Print arrival, queue, and departure messages for each customer

    TotalTimeUsed=departureTime(NumCustomer);
    for i=0:TotalTimeUsed
        for indexCus=1:NumCustomer
            if(arrivalTime(indexCus)==i)
                printf('\nMinute %03d: Arrival of customer %d at minute %d\n',i,indexCus,arrivalTime(indexCus));
                printf('Minute %03d: Customer %d has %d items in hand, and Customer %d queue at the counter %d\n',i,indexCus,noOfItems(indexCus),indexCus,queueCounter(indexCus));
            end
            if(departureTime(indexCus)==i)
                printf('Minute %03d: Departure of customer %d at minute %d.\n', i,indexCus, departureTime(indexCus));
            end
            if(serviceStart(indexCus)==i)
                printf('Minute %03d: Service for customer %d started at minute %d.\n', i, indexCus, serviceStart(indexCus));
            end
        end
    end
    printf('\n');
    %Return a success message
    y = 'Messages printed successfully.';
end