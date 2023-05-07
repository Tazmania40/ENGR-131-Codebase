%% Lab 8
% Tyler Zupfer
% 4/06/2023
% Group N/A

%% Question 1

% For some reason the scatter plots don't like staying with the line on the
% first go, just hit the button again and it'll work.

% Load Data File
load('ENGR131_23S_Lab8_Q1Data.mat')

% Get the fields of the weather structure
WeatherFields = fields(Weather);

% R2 is setup as [rainTot, snowTot; rainAvg, snowaAvg]
R2 = zeros(2);


% Nested Loop to compute each regression plot
for typeInd = 2:length(WeatherFields)
    % Rain, Snow
    if typeInd == 2
        type = "Rain";
    elseif typeInd == 3
        type = "Snow";
    end
    typeFields = fields(Weather.(type));
    for totAvgInd = 1:length(typeFields)-1
        % Total, Average
        if totAvgInd == 1
            totOrAvg = "Total";
        elseif totAvgInd == 2
            totOrAvg = "Avg";
        end

        % Plot the plot on correct plot.
        plotIndex = 2*(typeInd-2)+totAvgInd;

        hold("on");
        subplot(2,2, plotIndex);
        scatter(Weather.Tmax.Avg, Weather.(type).(totOrAvg));
        
        % Regression
        p = polyfit(Weather.Tmax.Avg, Weather.(type).(totOrAvg), 1);
        xfit = [12, 20];
        yfit = polyval(p, xfit);
        plot(xfit, yfit);
        yfit = polyval(p, Weather.Tmax.Avg);
        yresid = (Weather.(type).(totOrAvg)) - yfit;
        SSresid = sum(yresid.^2);
        SStotal = (length(Weather.(type).(totOrAvg))-1) * var(Weather.(type).(totOrAvg));
        R2(totAvgInd, typeInd-1) = 1 - SSresid/SStotal;
        
        % Plot Setup
        title("Correlation of " + totOrAvg + " " + (type) + " to Average Max Temp")
        xlabel("Average Yearly Tmax (deg C)")
        ylabel(totOrAvg + " " + (type) + "fall (cm)")
        hold("off");
    end
end

disp("Predictions make sense");

%% Question 2
figure();

% Load Data File
load('ENGR131_23S_Lab8_Q2MSG.mat')
sampFreq = 44100; 

%% 2A - Plot the raw signal
period = 1/sampFreq;
totalTime = length(MSG)*period;
time = (0:period:totalTime)';
time = time(1:length(time)-1);
plot(time, MSG)
title("Hidden Message")
xlabel("Time (s)")
ylabel("Amplitude")
xlim([0,totalTime]);

%% 2B - Fourier Transform, Plotted
figure()
Fw = fft(MSG/sampFreq);
shiftedData = fftshift(Fw);
freqs = -sampFreq/2:1/totalTime:sampFreq/2;
plot(freqs(1:end-1), abs(shiftedData));
title("Hidden Message - Fourier Transformed")
xlabel("Frequency")
ylabel("Amplitude")
xlim([0, 10000])

%% 2C - Spectrogram
figure()
freq = 0:44100;

spectrogram(MSG, 2048, 1900, freq, sampFreq, 'yaxis'); 

title("Hidden Message - Spectrogram")
xlabel("Time (s)")
ylabel("Frequency (KHz)")

%% 2D - Filtered Signal
figure()

% The noise is a 1567.67 hz tone (G6 for all you musicians), with an
% overtone slightly higher (which threw me off at first). Technically a low
% pass filter should suffice, but a band-stop filter would probably be more
% effective.

Wn = 900/(sampFreq/2);
[num, denom] = butter(6, Wn, 'low');

filtered = filter(num, denom, MSG);
plot(time, filtered);
title("Hidden Message - Filtered")
xlabel("Time (s)")
ylabel("Amplitude")

sound(filtered, sampFreq);

disp("The message is: " + "Welcome to the end of ENGR 131, Spring 2023" + ".")





