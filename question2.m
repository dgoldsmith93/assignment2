w = .3; %width in meters.
d = .03; %thickness in meters.
g = 9.81; %acceleration near earth's surface. Units of meter's/second^2.

f = -480*w*d*g; %constant force in this case. 

E = 1.3*10^10; %Young's Modulus of this wood. In units of Pascals.
I = (w*d^3)/12; %Area moment of intertia. Meters^4.
L = 2; %length in meters.
x = L; %payload. In this case uniform.

true_y = (f/(24*E*I))*(x^2)*(x^2 - 4*L*x + 6*L^2); %true analytical displacement of beam.

%test for values of true_y and y from question1 are within Machine Epsilon
%of each other.
% question1;
% 
% if (abs(true_y - y(length(y)) < 10^-16))
%     disp("nice!");
% end
