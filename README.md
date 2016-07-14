# Programming Specification
`This file is edited by Gang Huang to complete the coding challenge posted by Insight Data.` 

1.  [Caution] (README.md#caution)
2.  [Algorithm in programming] (README.md#algorithm-in-programming)
3.  [Amount of calculation] (README.md#amount-of-calculation)


##Caution

This programming is written by MATLAB. While running the code, a MATLAB toolbox called `JSONlab` is required. It is used to decode a JSON/UBJSON file into MATLAB data structure.

##Algorithm in programming

Naturally, the first idea is to decode the JSON file and extract the date, target and actor in each payment. They are stored in two different cell arrays `date` and `payments` separately. 

The main loop is to travel from the first payment to the last one and I use a vector `med` to record the medians. Then in the `n-th` iteration, I will set the last date as the current `clock`, and set the corresponding payments as the initial payments set (named as `paysets`). After the initial `clock` and `paysets` determined, there is a subloop which is from the `n-th` payments back to the beginning. Say the index of the subloop is `j`. If the date of `j-th`payment is within 60 seconds to the `clock`, then the programming will add the `j-th` payments into the `paysets` and form the corresponding adjacency matrix. 

The way to add the `j-th` payments into `paysets` is implemented by a nested function called `strcmb`. The output of the nested function is the new combined `paysets` and the corresponding adjacency matrix.


##Amount of calculation

Say the the number of the payments is `n`, then the amount of the calculation cannot be less than `n` because it must travel through all the payments. But the subloop will stop while there are two back-to-back payments whose dates are without 60 seconds to the `clock`. So obviously, the amount calculation is far less than `n square`. In fact, it is somehow up to the intervals of these payments. If the dates are close, the calculation will be big up to `n square`, otherwise, it can be small as `n`. For the biggest data whose size is over 1700, the programming will cost a few minutes.


