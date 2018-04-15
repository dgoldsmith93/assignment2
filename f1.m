n = 10;
A = zeros(n);

A(1,1:4 ) = [16 -9 8/3 -1/4];
A(2,1:4) = [-4 6 -4 1];
A(n-1,n-3:n) = [16/17 -60/17 72/17 -28/17];
A(n,n-3:n) = [-12/17 96/17 -156/17 72/17];
for i = 3:n-2
    A(i,i-2:i+2) = [1 -4 6 -4 1];
end

w = .3; %width in meters.
d = .03; %thickness in meters.
g = -9.81; %acceleration near earth's surface. Units of meter's/second^2.

f = -480*w*d*g; %constant force in this case. 

b = f*ones(n,1); %force vector.
y = A\b; %displacement vector.

%check:
% if(sum(A*y == b) == 0)
%     disp("nice!");
% end
