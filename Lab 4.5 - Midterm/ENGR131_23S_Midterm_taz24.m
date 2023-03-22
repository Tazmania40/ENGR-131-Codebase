%% Midterm
%{
Tyler Zupfer
02/27/2023
%}

%% Question 1
% Intentional clear for a fresh start.
clear
clf

% Load the Lab Data for the Midterm
load("/MATLAB Drive/ENGR 131/Lab 4.5 - Midterm/SubjectData.mat");

% For each table
for table = 1:size(SubjectData, 3)
    
    % Split into 8 sections, and set the current plot to the value of table
    subplot(2, 4, table)
    % Hold on to ensure all 3 conditions are plotted on the same graph
    hold("on");
    % For each condition
    for condition = 1:size(SubjectData, 2)
        % Remove the NaN values
        DataNoNaN = rmmissing(SubjectData(:, condition, table));
        % Set the line color for each condition
        switch condition
            case 1
                LineSpecs = 'r-o';
            case 2
                LineSpecs = 'g--o';
            case 3
                LineSpecs = 'b:o';
        end
        % Make a set of times that matches the length of each condition
        times = linspace(0, ...
            0.01*length(DataNoNaN), ...
            length(DataNoNaN));
        % Plot times and the data with the line color set above.
        plot(times, DataNoNaN, LineSpecs, 'LineWidth',2);
    end
    % Label the X and Y axies and title each graph
    xlabel("Time");
    ylabel("Data");
    title("Table " + table + "at 3 conditions");
    % Turn the hold off so we don't accidentally plot all the plots on the
    % same plot.
    hold("off")
end
% Add a proper legend at a nice spot on the graph
legend(["Current", "Novel", "Control"], 'Position', [0.65 0.15 0.25 0.25]);

%% Question 2
% Intentional clear(s) for a fresh start.
clear
clf
clc

% Inline conditional to ask the player whether they initially want to play.
prompt = input("Would you like to play the dice game? [P/Q]","s");
running = prompt == 'P' || prompt == 'p';

% Initial Conditions
compPoints = 0;
playPoints = 0;

% Game Loop
% Run the game for 5 rounds.
for roundNum = 1:5
    disp("Round: " + roundNum);
    % Design Condition - Computer always starts
    % COMPUTER TURN
    % Check if the computer is behind by 20 points or more.
    if (compPoints + 20 <= playPoints)
        disp("The computer is behind by 20 or more points and has decided to quit.")
        break
    end
    % If not, play the computer turn
    disp("The computer will now play.")
    points = rollDice();
    compPoints = compPoints + points;

    % PLAYER TURN
    disp("It is now the player's turn.")
    % Get the human player option
    selection = getHumanSelection();
    % Check if the selection is a q, if so, break, if not then we know that
    % the only other option is P and thus play the turn
    if selection == 'Q' || selection == 'q'
        break
    end
    points = rollDice();
    playPoints = playPoints + points;

    % Between Round Check In
    plotScores(compPoints, playPoints, roundNum)
end
disp("We have reached round 5 and it is time for the game to end.")


%% Functions - Question 2

% Get Human Selection Function
% Input: None
% Output: P or Q of the player
% Directions: Prompt the human for a selection to either P play or Q quit.
% Only accept these options.  Return this value to the calling script.
function selection = getHumanSelection()
while true
    prompt = input("Would you like to play or quit? [P/Q]","s");
    if prompt == 'P' || prompt == 'p' || prompt == 'Q' || prompt == 'q'
        selection = prompt;
        break
    else
        disp("That is not a valid option, please try again.")
    end
end
end

% Roll Dice Function
% Input: None
% Output: Score of the 5 dice rolled
% Directions: Simulate a random dice roll of 5 dice and implement the 
    % pertinent rules described above and compute the player’s score for 
    % that round.  Return this score back to the calling script.
function score = rollDice()
    % Generate the dice as needed
    dice = randi(6, [5, 1]);
    % Display the outcome
    disp("The roll is: ")
    disp(dice)
    % Sort in ascending order
    dice = sort(dice);
    % Count the number of ones
    ones = 0;
    for roll = 1:size(dice)
        if dice(roll) == 1
            ones = ones + 1;
            dice(roll) = 0;
        else
            break
        end
    end
    % Zero out for the number of ones starting from the end with a check to
    % ensure it happens at the correct time
    if ones ~= 0
        for roll = size(dice):-1:(size(dice) - ones)
            dice(roll) = 0;
        end
    end
    score = sum(dice);
end

% Plot Scores Function
% Input: Computer Score, Player Score
% Output: Graph of current score standings
% Directions: Simulate a random dice roll of 5 dice and implement the 
    % pertinent rules described above and compute the player’s score for 
    % that round.  Return this score back to the calling script.
function plotScores(compPoints, playPoints, roundNum)
    % Turn on the hold
    hold("on")
    % Plot and Label Each Player's Points -- labels done using categories
    % to ensure that the labels display correctly (was having issues with
    % tick labels.
    labels = categorical(["Computer Points", "Player Points"]);
    labels = reordercats(labels,["Computer Points", "Player Points"]);
    bar(labels, [compPoints, playPoints], "black")
    % No X label needed, but Y label and title
    ylabel("Scores (points)")
    title("Play after round " + roundNum)
    % Set background to Poker Green (because who doesn't love poker)
    set(gca, 'Color', '#35654d') 
    hold("off")
end
