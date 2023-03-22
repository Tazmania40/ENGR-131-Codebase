%% Lab 4
%{ 
Tyler Zupfer
02/14/2023
Group N/A
%}

%% Question 1
% Intentional clear for a fresh start.
clear
clf

% Load the Lab Data for Lab 4
load("C:\Users\tzupf\MATLAB Drive\ENGR 131\Lab 4\ENGR131_Lab4_Data.mat");

% Create an evenly spaced array from 1-5 of 100 values
time = linspace(0,5,100);

% For loop to loop through the dampCoeffSet
for index = 1:length(w)
    % Using CalcPosition from below, calculate the height at each time
    % For loop to loop through the dampCoeffSet
    for jindex = 1:length(DC)
        % Using CalcPosition from below, calculate the height at each time
        heights = CalcPosition(time, DC(jindex), w(index));
        % Plot the line height vs time
        plotGraphs(index, jindex, time, heights, w(index));
    end    
end

%% Question 2
% Intentional clear for a fresh start.
clear
clf

totCash = 0;
targetCash = 1000;
RoundNum = 1;

while totCash < targetCash
    % Wait for keypress and inform the user
    if RoundNum ~= 1
        disp('Press a key !');
        pause;
    end
    clf; % Prevent plots from stacking
    % Using the functions as requested by the lab to solve for ships, cash,
    % and to plot the current status.
    currentShips = GetShips();
    cash = CashPerRound(currentShips);
    totCash = totCash + cash;
    PlotRound(currentShips, cash, totCash, RoundNum);
    % Then update the number of rounds
    RoundNum = RoundNum + 1;
end

%% Functions - Question 1
% Create function CalcPosition
% Inputs: vector Time, value Dampning (Dampning Coefficient)
% Outputs: vector Height
function Height = CalcPosition(Time, Dampning, w)
    % Internal Constant, OmegaN 
    ConstOmegaN = 8;
    % Functions as described in Eq. 1, 2, 3
    weirdO = Dampning*ConstOmegaN;
    OmegaD = ConstOmegaN*(sqrt(1-(Dampning^2)));
    Height = 1 - (exp(-(weirdO.*Time)).*cos(OmegaD.*Time));
end
% Create function plotGraphs
% Inputs: 2 index variables, time value Dampning (Dampning Coefficient)
% Outputs: none
function plotGraphs(index, jindex, time, heights, wVal)
    dampCoeffs = evalin('base', 'DC');
    % Switch case to change the formatting of the line
    switch jindex 
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
    % Turn on the hold
    hold on;  
    subplot(2,3,index)
    plot(time, heights, LineColor)
    % Label the X and Y axies and title the graph
    xlabel("Time")
    ylabel("Height")
    title(["Time vs Height", "w = " + num2str(wVal)])
    axis([0, time(length(time)), 0, 2])
    % Turn off the hold
    hold off;
    if ((index == evalin('base', 'length(w)')) && jindex == length(dampCoeffs))
        legend(string(dampCoeffs), 'Position', [0.75 0.25 0.1 0.1])
    end
end
%% Functions - Question 2
% Create function GetShips
% Inputs: None
% Outputs: Length of ships at wharf
function wharf = GetShips()
    % Function made as described in Lab 4 Instructions
    numShips = randi(2,1,5)-1;
    wharf = zeros(1,5); % Make an empty Matrix
    for index = 1:length(numShips)
        if numShips(index) % Cool trick to see if the value is 0 because of 
                           % MATLAB auto type conversion
            wharf(index) = randi(6)*10; % 1-60 value 
        else
            wharf(index) = 0;
        end
    end  
end 

% Create function CashPerRound
% Inputs: Lengths of ships at wharf
% Outputs: Sum of money made for all ships that round
function totalCash = CashPerRound(lenShips)
    tenFtSum = sum(lenShips == 10); % Sum lengths of ships where their length is 10
    otherSum = 0; % Make another variable for the other lengths
    for inShip = 1:length(lenShips)
        if lenShips(inShip) > 10 % If the ship is not 10
            otherSum = otherSum + lenShips(inShip); % Add its length to the sum
        end
    end
    totalCash = tenFtSum*100 + otherSum; % Sum up value of all ships
end

% Create function PlotRound
% Inputs: Cash, roundNumber
% Outputs: None
function PlotRound(LenShips, roundCash, totCash, RoundNum)
    totCash = totCash/10; % Total Cash Rounding to ensure that things don't
                          % go off the page.
    figure(1); % Set the current figure to 1
    hold("on"); % Turn on a hold
    bar([LenShips roundCash totCash], "black"); % Plot the stuff with some 
                                         % cool trick to get it all to plot
    labels = [string([0, 1:length(LenShips)]) "Round: " + ...
        string(RoundNum) "Tot/10"]; % Make the labels with the cool trick
    % Add Tick Labels
    xticklabels(labels);
    % Label the X and Y axies and title the graph
    xlabel("Ship Number, Income this Round, Total Cash")
    ylabel("Length (ft) or dollars")
    title("Active Ships and Income")
    % Set a reasonable y limit
    ylim([0,100]) 
    % Set the color to hex code 0d3acd
    set(gca, 'Color', '#0d3acd') 
    hold("off") % Turn off the hold
end
