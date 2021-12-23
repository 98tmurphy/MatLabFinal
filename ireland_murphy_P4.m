%{ 
Final project Problem 4
By Tom Murphy
%}

%Constants
d     = .75;                %diameter of rod in question in in
r     = d / 2;              %radius of rod in question in in
V     = 60;                 %interal reaction force, measured in pounds
Mbend = 60 * 4;             %bending moment in lb*in
I     = (pi * d^4) / 64;    %moment of inertia for cross sectional area in in^4
J     = (pi * d^4) / 32;    %polar moment of inertia in in^4

c_H   = .375;   %vertical distance from center to point h in in^2
c_K   = 0;      %vertical distance from center to point k in in^2

a_K   = .5 *pi * r^2;       %area "above" point K
y_K   = (4 * r) / (3 * pi); %verical distance from center of circle to centroid of aK
Q_K   = a_K * y_K;          %Q value at point K
Q_H   = 0;                  %Q value at point H. Is just zero

thetaDeg = 0: 1: 180;           %degree of rotation
thetaRad = deg2rad(thetaDeg);   %degree of rotation in rads

%Forces and mopments
V     = 60;                     %interal reaction force, measured in pounds
Mbend = 60 * 4;                 %bending moment in lb*in
T     = 8 * 60 *sin(thetaRad);  %torssion the rod is under for a given angle

%Stresses
sigmaY_H = (Mbend * c_H) / I;   %stress from bending at point H in psi
sigmaY_K = (Mbend * c_K) / I;   %stress from bending at point K in psi

tauTorrsion_H = T * r / J;      %Stress from torrsion at point H in psi
tauTorrsion_K = tauTorrsion_H;  %Stress from torrsion at point K in psi

tauShear_H  = (V * Q_H) / (I * d);  %Shear stress at point H in psi
tauShear_K  = (V * Q_K) / (I * d);  %Shear stress at point K in psi


%Mohrs circle
C_H = sigmaY_H / 2; %The x coordinate of C for point H
C_K = sigmaY_K / 2; %The x coordinate of C for point K

Ax_H  = sigmaY_H;                   %The x coordinate of A for point H
Ay_H  = tauTorrsion_H - tauShear_H; %The Y coordinate of A for point H
Ax_K  = sigmaY_K;                   %The x coordinate of A for point K
Ay_K  = tauTorrsion_K - tauShear_K; %The Y coordinate of A for point K

R_H = sqrt((Ax_H - C_H).^2 + Ay_H.^2);  %Radius of circle at point H
R_K = sqrt((Ax_K - C_K).^2 + Ay_K.^2);  %Radius of Mohrs circle at point K

sigma1_H = C_H + R_H;   %Principal stress one at point H
sigma2_H = C_H - R_H;   %Principal stress two at point H
tauMax_H = R_H;         %Max torssion stress at pount H

sigma1_K = C_K + R_K;   %Principal stress one at point H
sigma2_K = C_K - R_K;   %Principal stress two at point H
tauMax_K = R_K;         %Max torssion stress at pount H

%plotting and outputting
figure
plot(thetaDeg, sigma1_H, '-r')
hold on
set(get(gca, 'Title'), 'String', 'Point H');
xlabel('Degrees \theta');
ylabel('Stress in psi');
plot(thetaDeg, sigma2_H, '-g');
plot(thetaDeg, tauMax_H, '-b');
legend('\sigma 1', '\sigma 2', '\tau Max');
hold off

figure
plot(thetaDeg, sigma1_K, '-r');
hold on
set(get(gca, 'Title'), 'String', 'Point K');
xlabel('Degrees \theta');
ylabel('Stress in psi');
plot(thetaDeg, sigma2_K, '-g');
plot(thetaDeg, tauMax_K, '-b');
legend('\sigma 1', '\sigma 2', '\tau Max');
hold off