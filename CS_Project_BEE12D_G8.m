% Nakagami-m Fading Model
% 16-QAM_900 MHz

% Abdur Rehman 337668
% Asad Ahmed 331881
% Syed Muhammad Abubakar 337385

% Communication Systems
% Semester Project

clear all;
close all;
clc;
format long

%Essential toolboxes required to run this file include:
%Simulink Design Optimization toolbox for makedist function: https://www.mathworks.com/products/sl-design-optimization.html  
%LTE toolbox for lteEVM function: https://www.mathworks.com/products/lte.html
%Statistics and Machine Learning Toolbox for nakagami distribution: https://www.mathworks.com/products/statistics.html

disp("Discussing the characteristics of 16-QAM_900 MHz signal:")
disp('');
disp("16-QAM stands for '16-Quadrature Amplitude Modulation.' It is a digital modulation technique that uses both amplitude and phase modulation to encode data onto the carrier signal." + ...
    "The 16-QAM_900 MHz signal has the following key characteristics: " + ...
    "1. 16-QAM Modulation: In 16-QAM, there are 16 distinct symbols, each representing a unique combination of amplitude and phase. " + ...
    "Since there are 16 symbols, each symbol can represent 4 bits (log2(16) = 4), as 2^4 = 16 which allows higher data rates. " + ...
    "2. Carrier Frequency: 900 MHz, falling within the UHF range, " + ...
    "commonly used in wireless communication systems. 3. Trade-off: Higher data rates come at the cost " + ...
    "of increased susceptibility to noise and interference, requiring a higher signal-to-noise ratio (SNR)" + ...
    " for reliable communication. In summary, the 16-QAM_900 MHz signal offers higher data rates due to its modulation scheme," + ...
    " operates at a 900 MHz carrier frequency, and has a trade-off between data rate and robustness.")
disp('')
%Given Signal: 16-QAM_900 MHz
%NOTE: CHANGE THIS ADDRESS TO THE LOCATION  OF THE QAM FILE ON UR PC
A=readmatrix('D:\work\sem 6\Comms\project\RF Signals\16-QAM_900 MHz.txt');
time = A(:,1);
input_signal = A(:,2);

%Deliverable 1: Plot of Input Signal vs. Time
plot(time, input_signal);title("Input Signal vs. Time");
xlabel("Time");ylabel("Amplitude");
figure
% Parameters
d0 = 1; % Reference distance (km)
PL_d0 = 0.001; % Path loss at reference distance (dB)
n = 3; % Path loss exponent for urban area
distance_range = 2:0.5:5; % Range of distances from 2 to 5 kilometers

% Calculate path loss for each distance in the range using vectorized operation
path_loss = PL_d0 + 10 * n * log10( distance_range/ d0);

% Transmit power
Transmit_dB = 0; % 0 dB is taken as reference at which QAM Signal is generated

% Calculate received power for each distance
receivedPower_dB = Transmit_dB - path_loss;
receivedPower_linear = 10 .^ (receivedPower_dB / 10);

% % Nakagami-m fading parameters

disp("Why was the mu parameter used?");
disp('')
disp("The mu parameter, also known as the 'shape parameter,' controls the shape of the distribution. " + ...
    "It is a positive real number that represents the fading severity in the channel. " + ...
    "When mu equals 1, the Nakagami distribution becomes the Rayleigh distribution, which models the worst-case fading scenario with no line-of-sight component. " + ...
    "As mu increases, the distribution approaches the Ricean distribution, which has a stronger line-of-sight component and less severe fading.")
disp('')
disp("Why was the omega parameter used?");
disp('')
disp("The omega parameter, also known as the 'spread parameter' or 'scaling parameter,'" + ...
    " controls the spread of the distribution. It is a positive real number that represents the mean power of the signal," + ...
    " or the average energy per symbol. This parameter determines the scale of the Nakagami distribution and is related to the received signal power. " + ...
    "When modeling wireless channels, the omega parameter often varies with the distance between the transmitter and receiver, as well as other factors " + ...
    "such as shadowing and path loss.")
m = 2; % mew: Shape parameter for Nakagami Distribution
for i=1:length(distance_range)
    omega(i) = abs(receivedPower_linear(i));  %spread parameter
    %Nagakami Probability Distribution
    pd = makedist('Nakagami', 'mu', m, 'omega', omega(i));  
  
    nakagamiFading1 = random(pd, length(input_signal),1);
    
    %Deliverable 2: Final Signal after Propagating through Nagakami-m Channel
    output_signal = input_signal.*nakagamiFading1;
    
    subplot(211);plot(time,output_signal);title ("Output Signal at "+distance_range(i)+" km. vs. Time");
    xlabel("Time");ylabel("Amplitude");
    subplot(212);plot(time(1:1000),output_signal(1:1000));title ("Zoomed in Signal at "+distance_range(i)+" km. vs. Time")
    figure
    %Calculation of Error Vector Magnotude for each Distance
    evm=lteEVM(output_signal,input_signal); 
    error_vector=abs(evm.EV);

    %Taking Mean of Error Vector for each Plot
    error(i)=mean(error_vector);
end

%Delivarble 4: Plot of EVM vs Distance
plot(distance_range,error);title("Plot of EVM vs Distance");
xlabel("Distance in km");ylabel("EVM");