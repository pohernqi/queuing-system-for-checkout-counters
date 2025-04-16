function y = CustomerCounterTable(rngenerator, NumCustomer, InterarrivalTime, arrivalRange, counterService, counterRange)
    
    %store the numofcustomer from 1 to n customers from input
    NumofCustomer_arr = [1:NumCustomer];
    
    if (rngenerator == 'LCG')
        %generate rnInterarrival from 1 to 100
        rnInterarrival = LCG(NumCustomer, 1, 100);
        
        %set first rnInterarrival to 0
        rnInterarrival(1) = 0;
        
        rnService = LCG(NumCustomer, 1, 100);
        noOfItems = LCG(NumCustomer, 1, 15);
        
    else %indicates generator ==RUD
        rnInterarrival = RUD(NumCustomer, 1, 100);
        rnInterarrival(1) = 0;
        rnService = RUD(NumCustomer, 1, 100);
        noOfItems = RUD(NumCustomer, 1, 15);
    end
    
    
    InterArrTime = zeros(1, NumCustomer);
    
    %for each rnInterarrival, generate exact interarrtime based on range
    for i = 1:numel(rnInterarrival)
        InterArrTime(i) = InterArrivalTime(InterarrivalTime, arrivalRange, rnInterarrival(i));
    end
    
    InterArrTime(1) = 0;
    arrivalTime = zeros(1, NumCustomer);
    arrivalTime(1) = 0;
    
    
    disp('Customer Table')
    disp('------------------------------------------------------------------------------------------');
    disp('| Cust No | RN Interarival time | Interarrival time  |  Arrival Time  |   No. of Items   |');
    disp('------------------------------------------------------------------------------------------');
    
    
    %calculate arrivaltime and display values in customer table
    for i = 1:numel(NumofCustomer_arr)
        if (i+1 <= numel(InterArrTime))
            arrivalTime(i+1) = arrivalTime(i) + InterArrTime(i+1);
        end
        fprintf('|  %3d    |        %3d          |         %d          |      %3d       |       %3d        | \n', [NumofCustomer_arr(i), rnInterarrival(i), InterArrTime(i), arrivalTime(i), noOfItems(i)]);
    end
    disp('------------------------------------------------------------------------------------------');
    
    
    %cust no in each counter
    no_cust_counter1 = zeros(1, NumCustomer);   
    no_cust_counter2 = zeros(1, NumCustomer);
    no_cust_counter3 = zeros(1, NumCustomer);
    no_cust_counter4 = zeros(1, NumCustomer);

    %store the index of customer
    no_cust_counter = {no_cust_counter1, no_cust_counter2, no_cust_counter3, no_cust_counter4}; 

    %store the total number of customer in each counter
    numcust = zeros(1, numel(no_cust_counter)); 
    
    %store the total number of all customer in the queue of each counter
    totalitemsincounter = zeros(1, numel(no_cust_counter)); 
    
    
    for i = 1:NumCustomer
        if noOfItems(i) < 5
            minIndex = 4;
            allSame = true;

            for j = 1:3
                if numcust(j) < numcust(minIndex)
                    minIndex = j;
                    allSame = false;
                elseif numcust(j) > numcust(minIndex)
                    allSame = false;
                end
            end
        
            if allSame
                for k = 1:3
                    totalitem = 0;
                    for j = 1:numcust(k)
                        totalitem = totalitem + noOfItems(no_cust_counter{k}(j));
                    end
                    totalitemsincounter(k) = totalitem;
                end

                minIndex = 4;

                for k = 2:3
                    if totalitemsincounter(k) < totalitemsincounter(minIndex)
                        minIndex = k;
                    end
                end
            end

            no_cust_counter{minIndex}(numcust(minIndex)+1) = i;

        else
            minIndex = 1;
            allSame = true;

            for j = 2:3
                if numcust(j) < numcust(minIndex)
                    minIndex = j;
                    allSame = false;
                elseif numcust(j) > numcust(minIndex)
                    allSame = false;
                end
            end

            if allSame
                totalitemsincounter = zeros(1, numel(no_cust_counter));
                for k = 1:3
                    totalitem = 0;
                    for j = 1:numcust(k)
                        totalitem = totalitem + noOfItems(no_cust_counter{k}(j));
                    end
                    totalitemsincounter(k) = totalitem;
                end

                minIndex = 1;

                for k = 2:3
                    if totalitemsincounter(k) < totalitemsincounter(minIndex)
                        minIndex = k;
                    end
                end
            end

            no_cust_counter{minIndex}(numcust(minIndex)+1) = i;
        end

        for j = 1:numel(no_cust_counter)
            count = 0;
            for k = 1:NumCustomer
                if no_cust_counter{j}(k) == 0
                    break;
                else
                    count = count + 1;
                end
            end
            numcust(j) = count;
        end
    end

  
    Cus_TimeServiceBegin = zeros(1, NumCustomer);
    Cus_TimeServiceEnds= zeros(1, NumCustomer);
    Cus_ServiceTime=zeros(1, NumCustomer);
    Cus_WaitingTime= zeros(1, NumCustomer);
    Cus_TimeSpentInSystem= zeros(1, NumCustomer);

    %calculate time service begin, timeservice end, service time, waiting time, time spent in system
    for counter = 1:4
        for customer = 1:numcust(counter)    
            if(customer==1) % if is first customer
             %set arrivalTime, waitingTime to 0
            Cus_TimeServiceBegin(no_cust_counter{counter}(customer)) = arrivalTime(no_cust_counter{counter}(customer));
            Cus_WaitingTime(no_cust_counter{counter}(customer))= 0;
            
          else
             if(arrivalTime(no_cust_counter{counter}(customer))>= Cus_TimeServiceEnds(no_cust_counter{counter}(customer-1)))
                  Cus_TimeServiceBegin(no_cust_counter{counter}(customer)) = arrivalTime(no_cust_counter{counter}(customer));
             else
                  Cus_TimeServiceBegin(no_cust_counter{counter}(customer)) = Cus_TimeServiceEnds(no_cust_counter{counter}(customer-1)) ;
             end
              %set waitingTime to 0 if obtain negative value using max
             Cus_WaitingTime(no_cust_counter{counter}(customer))= max(0,Cus_TimeServiceBegin(no_cust_counter{counter}(customer)) - arrivalTime(no_cust_counter{counter}(customer)));
             
          end
            Cus_ServiceTime(no_cust_counter{counter}(customer))= ServiceTime(counterService{counter}, counterRange{counter}, rnService(no_cust_counter{counter}(customer)));
            Cus_TimeServiceEnds(no_cust_counter{counter}(customer)) =  Cus_ServiceTime(no_cust_counter{counter}(customer)) + Cus_TimeServiceBegin(no_cust_counter{counter}(customer));
            Cus_TimeSpentInSystem(no_cust_counter{counter}(customer))= Cus_ServiceTime(no_cust_counter{counter}(customer))+ Cus_WaitingTime(no_cust_counter{counter}(customer));
        end
    end
    
    
     queueCounter = zeros(1, NumCustomer);
        for counter = 1:numel(no_cust_counter)
            for i = 1:numcust(counter)
            queueCounter(no_cust_counter{counter}(i)) = counter;
        end
    end

    % Call the PrintMessage function to print the messages
    DisplayMessage(NumCustomer, no_cust_counter, arrivalTime, queueCounter, Cus_TimeServiceEnds, Cus_TimeServiceBegin,noOfItems);
    

  %display info from counter 1 to 4
    printf('\n');
    for counter = 1:4
        if (counter < 4)
            disp(['Counter ', num2str(counter), ' (Normal)']);
        else
            disp(['Counter ', num2str(counter), ' (Express)']);
        end;
        disp('---------------------------------------------------------------------------------------------------------------------------');
        disp('| Cust No | RN Service time | Service time | Time Service Begin | Time Service Ends | Waiting Time | Time spent in System |');
        disp('---------------------------------------------------------------------------------------------------------------------------');
        for i = 1:numcust(counter)         
            fprintf('|  %3d    |      %3d        |      %d       |        %3d         |       %3d         |     %3d      |          %3d         |\n', [no_cust_counter{counter}(i), rnService(no_cust_counter{counter}(i)),Cus_ServiceTime(no_cust_counter{counter}(i)), Cus_TimeServiceBegin(no_cust_counter{counter}(i)), Cus_TimeServiceEnds(no_cust_counter{counter}(i)),Cus_WaitingTime(no_cust_counter{counter}(i)),Cus_TimeSpentInSystem(no_cust_counter{counter}(i)) ]);
        end
        disp('---------------------------------------------------------------------------------------------------------------------------');
        printf('\n');
    
    end

    %display evaluation 
  DisplayEvaluation(NumCustomer, no_cust_counter, numcust, Cus_WaitingTime,InterArrTime, arrivalTime, Cus_TimeSpentInSystem, Cus_ServiceTime );