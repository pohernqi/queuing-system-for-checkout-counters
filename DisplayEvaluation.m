function y = displayEvaluation(NumCustomer, no_cust_counter, numcust, Cus_WaitingTime, InterArrTime, arrivalTime,  Cus_TimeSpentInSystem, Cus_ServiceTime)
    totalWaitTime=0;
    totalInterArrTime=0;
    totalArrivalTime=0;
    totalCusTimeSpent=0;
    count=0;
    totalService= zeros(1, 4);
    avgService= zeros(1,4);
    
    
    %find totalwaitTime, totalInterArrTime, totalArrivalTime, totalCusTimeSpent
     for customer = 1: NumCustomer 
            totalWaitTime= Cus_WaitingTime(customer)+ totalWaitTime;
            totalInterArrTime= InterArrTime(customer)+ totalInterArrTime;
            totalArrivalTime= arrivalTime(customer) + totalArrivalTime;
            totalCusTimeSpent= Cus_TimeSpentInSystem(customer) +  totalCusTimeSpent;
            
            if(Cus_WaitingTime(customer) > 0)
               count = count + 1;
            end
            
     end
     
     
     %calculate total service time for each counter
     for counter=1:4
          totalServiceTime=0;
          for i = 1: numcust(counter)
              totalServiceTime= Cus_ServiceTime(no_cust_counter{counter}(i))+ totalServiceTime;
          end
          totalService(counter)=totalServiceTime;
     end
     
     
     %find the avg and probability
     avgWait= totalWaitTime / NumCustomer;
     avgInterArr=  totalInterArrTime / (NumCustomer-1);
     avgArrivalTime =  totalArrivalTime / NumCustomer;
     avgCusTimeSpent=  totalCusTimeSpent / NumCustomer;
     probWait= count / NumCustomer; 
     
     
     %display the message
    fprintf('The average waiting time:  %0.4f\n\n', avgWait);
    fprintf('The average interarrival time spent:  %0.4f\n\n', avgInterArr);
    fprintf('The average arrival time spent:  %0.4f\n\n', avgArrivalTime);
    fprintf('The average time spent in system:  %0.4f\n\n', avgCusTimeSpent);
    
   
    for i=1: numel(avgService)
         avgService(i)= totalService(i) / numcust(i);
         fprintf('The average service time for counter %d:  %0.4f\n\n', i, avgService(i));  
    end

   fprintf('The probability of a customer having to wait:  %0.4f\n\n', probWait);
     
     
     
            
   