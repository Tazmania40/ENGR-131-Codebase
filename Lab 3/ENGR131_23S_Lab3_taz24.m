%% Lab 3
%{ 
Tyler Zupfer
02/06/2023
Group N/A
%}
%% Question 1
% Intentional clear for a fresh start.
clear
% Get the damping coefficient from the command line
dampCoeff = input("Please enter a damping coefficient: ");
% While loop that also functions as an if-else because the loop repeats if
% dampcoeff is less than 0.
while dampCoeff < 0
    disp("You entered " + dampCoeff + ". " + ...
        "Please enter a POSITIVE starting coefficient.");
    dampCoeff = input("Please enter a damping coefficient: ");
end
% Else Condition of the while loop/if statement
disp("You entered " + dampCoeff + ". " + ...
        "This is acceptable.");
% Set of Damp Coeffs
dampCoeffSet = linspace(dampCoeff, 5*dampCoeff, 5);

% Create an evenly spaced array from 1-5 of 100 values
time = linspace(0,5,100);
% Hold to ensure everything gets plotted on the same plot
hold on;

% For loop to loop through the dampCoeffSet
for index = 1:length(dampCoeffSet)
    % Using CalcPosition from below, calculate the height at each time
    height = CalcPosition(time, dampCoeffSet(index));
    [minVal, mindex] = min(height);
    
    % Switch case to change the formatting of the line
    switch index 
        case 1 
            LineColor = 'k-'; 
        case 2 
            LineColor = 'b-';
        case 3
            LineColor = 'r-'; 
        case 4 
            LineColor = 'g-';
        case 5
            LineColor = 'm-';
        otherwise
            LineColor = 'y-';
    end 

    % Plot the line height vs time in black
    plot(time, height, LineColor);
    
end
% Label the X and Y axies and title the graph
xlabel("Time")
ylabel("Height")
title("Time vs Height at multiple Dampening Coefficients")
% Set a limit to the y axis so it looks nice
ylim([0,2])
% Turn off the hold
hold off;  

%% Question 2
% Intentional clear for a fresh start.
clear

% Create ,an evenly spaced array from 1-5 of 100 values
time = linspace(0,5,10000);

% Make a variable called running because there isn't an obvious exit
% Make a counter for the loop
counter = 0;
% Make a variable dampCoeff using a starting value of say .15
dampCoeff = 0.10;

% Default Values for the loop
heights = CalcPosition(time, dampCoeff);

% Run a loop
while max(heights) - heights(length(heights)) >= ...
          0.05*heights(length(heights))
    % Each time through:
    % Call the CalcPosition function
    heights = CalcPosition(time, dampCoeff); 
    % Increment the dampCoeff by 0.1
    dampCoeff = dampCoeff + 0.1;
    % Increment a counter
    counter = counter + 1;
end

% Report the number of iterations
disp("Number of iterations: " + counter)
% Report the final damping coefficient
disp("Final Damping Coefficient: " + dampCoeff)
% Plot the behavior of the system using this damping coefficient
plot(time, heights);    
% Label the X and Y axies and title the graph
xlabel("Time")
ylabel("Height")
title("Time vs Height at multiple Dampening Coefficients")
% Set a limit to the y axis so it looks nice
ylim([0,2])
% Turn off the hold
hold off;  

%% Function(s)
% Create function CalcPosition
% Inputs: vector Time, value Dampning (Dampning Coefficient)
% Outputs: vector Height
function Height = CalcPosition(Time, Dampning)
    % Internal Constant, OmegaN 
    ConstOmegaN = 8;
    % Functions as described in Eq. 1, 2, 3
    weirdO = Dampning*ConstOmegaN;
    OmegaD = ConstOmegaN*(sqrt(1-(Dampning^2)));
    Height = 1 - (exp(-(weirdO.*Time)).*cos(OmegaD.*Time));
end  
