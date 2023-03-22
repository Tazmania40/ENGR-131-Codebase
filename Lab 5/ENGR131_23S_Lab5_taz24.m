%% Lab 5
% Tyler Zupfer
% 2/27/2023
% Group N/A

%% Question 1

% Equations as text (rearranged while written because it was easier that
    % way)
% 2b + 2c + p + 2t = 506
% c + g + 2l + s + 2t = 570
% l + 3p - s = 548
% 2g + 2t + 3s = 573
% 5b + 2p = 615
% b + 4g + s - t = 605
% b + c + l + p + s + t = 639

% Numeric Approach
% All the variables with 0s for coeffs
% 2b + 2c + 0g + 0L + 1p + 0s + 2t = 506
% 0b + 1c + 1g + 2L + 0p + 1s + 2t = 570
% 0b + 0c + 0g + 3L + 3p - 1s + 0t = 548
% 0b + 0c + 2g + 0L + 0p + 3s + 2t = 573
% 5b + 0c + 0g + 0L + 2p + 0s + 0t = 615
% 1b + 0c + 4g + 0L + 0p + 1s + -1t = 605
% 1b + 1c + 1g + 1L + 1p + 1s + 1t = 639

% Translate into A and B matricies
A = [2 2 0 0 1 0 2; 0 1 1 2 0 1 2; 0 0 0 3 3 -1 0; 0 0 2 0 0 3 2; ...
        5 0 0 0 2 0 0; 1 0 4 0 0 1 -1; 1 1 1 1 1 1 1];
B = [506; 570; 548; 573; 615; 605; 639];
% Preform the inverse division
X = A\B;
% Output the results

output = char(round(X)')

% Symbolic Approach
syms b c g l p s t

Eq1 = 2*b + 2*c + p + 2*t == 506;
Eq2 = c + g + 2*l + s + 2*t == 570;
Eq3 = 3*l + 3*p - s == 548;
Eq4 = 2*g + 3*s + 2*t == 573;
Eq5 = 5*b + 2*p == 615;
Eq6 = b + 4*g + s + - t == 605;
Eq7 = b + c + g + l + p + s + t == 639;

% Use symbolic solver to solve 
Sol = solve(Eq1, Eq2, Eq3, Eq4, Eq5, Eq6, Eq7);


% Set up for next loop
fields = fieldnames(Sol);
solnsArray = [];

% Loop through the fields
for i = 1:numel(fields)
  solnsArray = [solnsArray; round(eval(Sol.(fields{i})))];
end

% Output the results
output = string(char(solnsArray)')


%% Question 2

% Set up Constants
dt = 0.1;
a1 = 1;
a2 = 0.75;
b1 = 2.25;
b2 = 3;
c1 = 1.25;
c2 = 3;

% Make a time vector
time = 0:0.1:5;

% Make a symbolic function for each set of constants
syms t
MR1 = a1*exp(-(b1*exp(-(c1*t))));
MR2 = a2*exp(-(b2*exp(-(c2*t))));

% Convert each to valid MatLab Functions
Metabolism1 = matlabFunction(MR1);
Metabolism2 = matlabFunction(MR2);

% Get the outputs of each function
output1 = Metabolism1(time);
output2 = Metabolism2(time);

% Trapezoidal Method (no semicolons so output is reported)
function1TrapMethod = trapz(output1)
function2TrapMethod = trapz(output2)

% Calculate the Riemann Sums (no semicolons so output is reported)
function1RiemannSum = rsum(Metabolism1, 0, 5, 0.1)
function2RiemannSum = rsum(Metabolism2, 0, 5, 0.1)

% Plot Graph as shown in figure 2
hold("on")
plot(time, output1, "b")
plot(time, output2, "r")
hold("off")
xlim([0,5])
ylim([0, 1.25])
xlabel("Time (min)")
ylabel("Normalized Metabolic Rate (J/min)")
title("Metabolism as a function of intervention")
legend("Current", "Test Drug")


%% Question 2 - Functions
% Make a function for the metabolism function to make life easy
function output = metabolism(a, b, c, time)
    % M = ae^(-be^(-ct)
    output = a*exp(-(b*exp(-(c*time))));
end

% Function to calculate the right Riemann Sum
function sum = rsum(f,a,b,dx)
sum = 0;
for index = 1:length(a:dx:b)
    xval = a + index*dx;
    sum = sum + f(xval);
end
end





