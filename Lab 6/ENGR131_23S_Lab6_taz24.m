%% Lab 5
% Tyler Zupfer
% 3/22/2023
% Group N/A

%% Question 1
% Load datafile
load('ENGR131_23S_Lab06_HeightData.mat')

% Plot figure 1a
hold('on')
plot(HeightData.Females, "r", "DisplayName", "Females")
plot(HeightData.Males, "b", "DisplayName", "Males")
legend()
xlabel("Observations")
ylabel("Height (cm)")
title("Recorded Heights by gender")
hold('off')

% clear figure between parts
clf

% Plot figure 1b
hold('on')
histogram(HeightData.Females)
histogram(HeightData.Males)
legend("Males", "Females")
xlabel("Height (cm)")
title("Height Distribution by Gender")
hold('off')

%% Question 2
% clear figure between parts
clf

% Calculate each datapoint for Female Set
femaleMean = mean(HeightData.Females);
femaleStdDev = std(HeightData.Females);
femaleMedian = median(HeightData.Females);
femaleMax = max(HeightData.Females);
femaleMin = min(HeightData.Females);

% Calculate each datapoint for Male Set
maleMean = mean(HeightData.Males);
maleStdDev = std(HeightData.Males);
maleMedian = median(HeightData.Males);
maleMax = max(HeightData.Males);
maleMin = min(HeightData.Males);

% Make a male and female set to put into the table
Male = [maleMean; maleStdDev; maleMedian; maleMax; maleMin];
Female = [femaleMean; femaleStdDev; femaleMedian; femaleMax; femaleMin];

% Make the table
stats = table(Male, Female, VariableNames = ["Male", "Female"]);
% Set the row names properly
stats.Properties.RowNames = ["Mean", "Standard Deviation", "Median", "Maximum", "Minimum"];

% Preform the paired T-test
[~, p] = ttest(HeightData.Females, HeightData.Males);

% Print P Value
disp("P Value is " + p);

% Draw conclusions based on an if statement
if p <= 0.05
    disp("The populations are statistically different.");
else
    disp("The populations are NOT statistically different.");
end

%% Question 3
% clear figure between parts
clf
% Create a general struct for the sorted heights
SortedHeights = struct;
% Make a general matrix times for the respective times of each process
% Column 1 is manual, Column 2 is MatLab, Row 1 is Females, Row 2, Males
times = [];

% Time and Sort Females Manually
tic()
SortedHeights.Females.manual = ascendSelctionSort(HeightData.Females);
times = toc();
% Time and Sort Females via MATLab
tic()
SortedHeights.Females.MatLab = sort(HeightData.Females);
times = [times, toc()];
% Time and Sort Males Manually
tic()
SortedHeights.Males.manual = ascendSelctionSort(HeightData.Males);
times = [times; toc(), 0];
% Time and Sort Males via MATLab
tic()
SortedHeights.Males.MatLab = sort(HeightData.Males);
times(2, 2) = toc();

% Plot the 4 datasets

hold("on")
plot(SortedHeights.Females.manual, "r square", "DisplayName", "Females Manual")
plot(SortedHeights.Females.MatLab, "r", "DisplayName", "Females Auto")
plot(SortedHeights.Males.manual, "b square", "DisplayName", "Males Manual")
plot(SortedHeights.Males.MatLab, "b", "DisplayName", "Males Auto")
legend()
xlabel("Height (cm)")
ylabel("Observation")
title("Sorted Height by Gender and Sort Method")
hold("off")

% Report average time for the manual and Matlab Sorts
disp("Mean time for Manual: " + mean(times(:, 1)))
disp("Mean time for MatLab: " + mean(times(:, 1)))

%% Question 4
% Load datafile
load('ENGR131_23S_Lab06_TrialData.mat')






%% Function(s) Question 3
function sorted = ascendSelctionSort(input)
for i = 1:length(input)-1
    IndexLow = i;
    for j = i+1:length(input)
        if input(j) < input(IndexLow)
        IndexLow = j;
        end
    end
    temp = input(i);
    input(i) = input(IndexLow);
    input(IndexLow) = temp;
end
sorted = input;
end





