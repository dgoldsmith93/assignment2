
    n = 10*(2^6);
    A = sparse(zeros(n));

    A(1,1:4 ) = [16 -9 8/3 -1/4];
    A(2,1:4) = [-4 6 -4 1];
    A(n-1,n-3:n) = [16/17 -60/17 72/17 -28/17];
    A(n,n-3:n) = [-12/17 96/17 -156/17 72/17];
    for i = 3:n-2
        A(i,i-2:i+2) = [1 -4 6 -4 1];
    end
    L = 2; %length in meters.
    x= L/n:L/n:L;
    w = .3; %width in meters.
    d = .03; %thickness in meters.
    g = 9.81; %acceleration near earth's surface. Units of meter's/second^2.
    s = -g*350*(x >= 1.8);
   
    f = (-480*w*d*g) + s; %no longer a constant force because x now varies from 0 to L. 
   

    E = 1.3*10^10; %Young's Modulus of this wood. In units of Pascals.
    I = (w*d^3)/12; %Area moment of intertia. Meters^4.
   

    h = L/n;

    b = ((h^4)/(E*I))*f.*ones(n,1)'; %force vector.
    y = A\b'; %displacement vector.
    
%     x1=L;
%     f1 = (-480*w*d*g) - (g*87.5);
%     
%     true_y = (f1/(24*E*I))*(x1^2)*(x1^2 - 4*L*x1 + 6*L^2); %results indicate that error is extremely low until ~2^9.
    %check:
    % if(sum(A*y == b) == 0)
    %     disp("nice!");
    % end
   % errors = abs( ( true_y - y(length(y)) ) ) / (true_y);
