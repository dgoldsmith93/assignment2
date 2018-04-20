errors = zeros(11,1);
hs = zeros(11,1);
for k = 1:11
    n = 10*(2^k);
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
    p = 100; %sinusoidal pile term. kg/meter.
    s = -(p*g*sin(pi.*x/L));
    f = -480*w*d*g+s; %no longer a constant force because x now varies from 0 to L. 
   

    E = 1.3*10^10; %Young's Modulus of this wood. In units of Pascals.
    I = (w*d^3)/12; %Area moment of intertia. Meters^4.
   

    h = L/n;
    
    b = ((h^4)/(E*I))*f.*ones(n,1)'; %force vector.
    y = A\b'; %displacement vector.
    
    x1=L;
    f1 = -480*w*d*g;
    a1 = p*g*L;
    a2 = E*I*pi;
    af = a1/a2;
    b1 = (L/pi)^3;
    b2 = sin(pi*x1/L);
    bf = b1*b2;
    cf = (x1^3)/6;
    df = L*(x1^2)/2;
    ef = ((L/pi)^2)*x1;
    
    true_y = (f1/(24*E*I))*(x1^2)*(x1^2 - 4*L*x1 + 6*L^2) - (af*(bf-cf+df-ef)); %results indicate that error is extremely low until ~2^9.
    %check:
    % if(sum(A*y == b) == 0)
    %     disp("nice!");
    % end
    errors(k) = abs((true_y - y(length(y)))/(true_y));
    hs(k) = h;   
end
figure; plot(log(hs.^2),log(errors)); %min for k=5. seems to almost be fixed point (x=-12.92,y=12.49).