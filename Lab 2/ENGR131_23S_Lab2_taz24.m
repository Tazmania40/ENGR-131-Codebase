%% Lab 2
%{ 
Tyler Zupfer
01/30/2023
Group N/A
%}
% Intentional clear for a fresh start.
clear;
%%
% Load file at this path into MATLAB
load("/MATLAB Drive/ENGR 131/Lab 2/ENGR131_23S_IN_032_04.mat");

% Get the damping coefficient from the command line
dampcoeff = input("Please enter a damping coefficient: ");
% Display the damping coefficient to the user
disp("Your selected damping coefficient is " + dampcoeff);

if (dampcoeff > 0)
    % Create an evenly spaced array from 1-5 of 60 values
    time = linspace(0,5,60);
    % Using CalcPosition from below, calculate the height at each time
    height = CalcPosition(time, dampcoeff);
    [minVal, index] = min(height);
    % Hold to ensure everything gets plotted on the same plot
    hold on;
    % Plot the line height vs time in black
    plot(time, height, "Color", "#000000");
    % Plot the minimum value as a red diamond
    plot(minVal, "Color", "#e42000", "Marker", "diamond");
    % Label the X and Y axies and title the graph
    xlabel("Time")
    ylabel("Height")
    title("Time vs Height")
    % Set a limit to the y axis so it looks nice
    ylim([-1.5 1.5])
    hold off;
else
     ENGR131_23S_IN_032_05(Warning, Fs);
end

% Create function CalcPosition
% Inputs: vector Time, value Dampning (Dampning Coefficient)
% Outputs: vector Height
function Height = CalcPosition(Time, Dampning)
    % Internal Constants, Omega and A
    ConstOmega = 3;
    ConstA = 1.5;
    % Function as described in Eq. 1
    Height = exp(-(Dampning.*Time)).*ConstA.*cos(ConstOmega.*Time);
end    