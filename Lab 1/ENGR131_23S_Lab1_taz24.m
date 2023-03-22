%% Lab 1
%{ 
Tyler Zupfer
01/23/2023
Group N/A
%}
clear % Intentional clear for a fresh start.
%% Question 1
%{ 
Use Matlab to create the following single-element variables.  Use the pertinent functions discussed in class 
to do this – do not manually type in the values.  Also, do not suppress the output so that they appear in the 
command window (5 pts): 
A  = < a real number in the range 6 to 33) >      
B = < an integer in the inclusive range from 0 to 15 >   
C= < a real number in the range 0 to 13 > 
D = < an integer in the inclusive range from 85 to 175 > 
E = < A real number in the range 28 to 83 >
%}
A = (rand*(33-6))+6 % random real in range 6-33
B = randi([0 15],1,1) % random int in range 0-15 inclusive (from MATLAB docs)
C = (rand*(13)) % random real in range 0-13
D = randi([85 175],1,1) % random int in range 85-175 inclusive (from MATLAB docs)
E = (rand*(83-28))+28 % random real in range 28-83
clear
%% Question 2
clear
%{
The combined resistance RT of three resistors R1, R2, and R3 in parallel is given by the formula below 
(eq.  1).    Create  variables  for  the  three  resistors,  store  values  in  each,  and  then  calculate  the  combined  
resistance RT if R1=1500, R2=3200, R3=6525.  Do not suppress the output so that these variables appear 
in the command window (5 pts)
%}
% Make 3 vars
R1 = 1500
R2 = 3200
R3 = 6525
% Implement equation
Rt = 1/((1/R1)+(1/R2)+(1/R3))

%% Question 3
clear
%{
Create two variables x and y and store numbers in them. Write an expression that would be TRUE if the 
value of x is greater than 12 OR if the value of y is less than 26, BUT not if both of those are true.  Do not 
suppress the output so that these variables appear in the command window (10 pts). 
%}
% Create variables
x = 4
y = 7
% Do logic
output = xor(x > 12, y < 26)

%% Question 4
clear
%{
Create the following arrays as variables. Do not suppress the output so that they appear in the command 
window (4 pts, 1 pt each):
%}
A = [1:5] % Matrix from 1-5
B = [2,5; 7,11; 9,3] % Manual matrix creation
% C the more fun dynamic way
% Make a 3x3 ones matrix
C = ones(3);
for r = 1:size(C, 1)
    for c = 1:size(C, 2)
        % For each variable in that ones matrix, multiply it by 6
        C(r,c) = 6*C(r,c); % Semicolon terminated to prevent terminal spam
    end
end
C = C % Workaround for not knowing how to print a variable in MATLAB
% or C the boring way
C = [6,6,6; 6,6,6; 6,6,6] % Manually set values in a 3x3 matrix
D = randi([4 16], 1, 5) % Make a random 1x5 matrix of integers from 4-16

%% Question 5
% No Clear statement here to ensure matricies still exist
%{
WITHOUT CLEARING YOUR WORKSPACE, perform the following operations on these variables 
to create the following arrays as variables. Do not suppress the output so that they appear in the command 
window (10 pts, 1 pt each):
%}
E = transpose([A(1:3); A(3:5)])
Q2b = E + B % Add elementwise
Q2c = E - B % Subtract elementwise
Q2d = E.*B % Dot Product
Q2e = E * transpose(B)  %{ Cross Product requires 2 matricies that are opposites, in this case 2x3 and 3x2. %}
Q2f = rem(A, 2) 
% 0 means an even division (num mod 2 is 0), 1 means an uneven division (num mod 2 is 1)
[MinD1, MindexD] = min(D)
Q2i = sum(C)
Q2j = logical(E>=3)
Q2k = logical(B>E)
A = transpose(A)

%% Question 6 
%{
Solve the following WITHOUT using Matlab. List your answers in your script as comments. Be sure to 
show your intermediate steps as well as the final answer (10 pts):
a. xor('e' == 'f' - 1, 3 < 5)
xor('e' == 'e', 3 < 5)
xor(true, true)
false

b. 11 > 6 + 6
11 > 12
false

c. 4 == 5 - 2
4 == 3
false

d. 'c' > 'a' + 5
'c' > 'f'
false

e. 'j' == 'k' - 1 && 8 > 7
'j' == 'j' && 8 > 7
true && true
true

f. xor('c' == 'd' - 1, 0 > 2)
xor('c' == 'c', 0 > 2)
xor(true, false)
true

g. 10 > 5 > 6
true > 6
1 > 6
false

h. 'a' >= 'c' –2
'a' >= 'a'
true

i. (12 > 4) + 4
true + 4
1 + 4
5

j. ‘j’ == ’k’ - 2 || 5 < 13
'j' == 'j' || 5 < 13
true || true
true

In the case of J, technically the computer would immediately solve the or to true and circumvent the rest of the logic.

%}
% Doing each of the statements above to show that my solutions are correct, commented out for your convienience.
%{
a = xor('e' == 'f' - 1, 3 < 5)
b = 11 > 6 + 6
c = 4 == 5 - 2
d = 'c' > 'a' + 5
e = 'j' == 'k' - 1 && 8 > 7
f = xor('c' == 'd' - 1, 0 > 2)
g = 10 > 5 > 6
h = 'a' >= 'c' -2
i = (12 > 4) + 4
j = 'j' == 'k' -2 || 5 < 13
%}
