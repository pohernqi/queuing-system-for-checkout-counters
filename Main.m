while true
    printf('Below are the options of Random Number Generator :\n')
    printf('1 - Linear Congruential Generators (LCG)\n2 - Random Uniform Distribution Generator (RUD)')
    printf('\n\nPlease choose either one\n')
    g=input('Enter : ')
    
    if (g==1)
        rngenerator='LCG'
        break
        
    elseif (g==2)
        rngenerator='RUD'
        break
        
    else
        printf('Your input is invalid! Please choose either 1 or 2\n\n')
    end
    
end

%initialize every counter service time
counterService1 = [3, 4, 5, 6, 7];
counterService2 = [2, 3, 4, 5, 6];
counterService3 = [3, 4, 5, 6, 7];        
counterService4 = [1, 2, 3, 4, 5];

%initialize every counter range
counterRange1 = [25, 45, 85, 95, 100];
counterRange2 = [15, 45, 70, 80, 100];
counterRange3 = [5, 20, 45, 75, 100];
counterRange4 = [25, 65, 95, 98, 100];

%put all the counter service time and range into an array
counterService = {counterService1, counterService2, counterService3, counterService4};
counterRange = {counterRange1, counterRange2, counterRange3, counterRange4};

%show all counter table  
CounterTable(counterService, counterRange);

%initialize inter-arrival time & range
arrivalTime = [1, 2, 3, 4, 5, 6];
arrivalRange = [15, 40, 50, 70, 85, 100];

%show inter-arrival time table
InterArrivalTable(arrivalTime, arrivalRange);

%prompt user to enter num of customer
NumCustomer=input('Enter number of customer : ');
printf('\n');
CustomerCounterTable(rngenerator, NumCustomer, arrivalTime, arrivalRange, counterService, counterRange);