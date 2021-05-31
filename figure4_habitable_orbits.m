% set the time span
tspan = [0, 200];
% set the relative error
reltol = 1e-10;
% generate ODE solving options
opts = odeset('RelTol',reltol);
% opts = odeset('AbsTol', reltol);

%for pi=0.1:0.01:0.2
figure()
%ind = 1;
%t = [stable_fine1(1,ind);stable_fine1(3,ind)];
% set a range of initial conditions [x, y, xdot, ydot]
ic = [1.733; 0; 0; -1.6944];
% solve the ODE
% omega is rotational speed of 3 stars
w = (1/3)^(1/4);
% give position of stars in their static frame
star_pos = [1, -1/2, -1/2;0, sqrt(3)/2, -sqrt(3)/2];
[t,r] = ode45(@(t,y) odefun(t,y,w,star_pos), tspan, ic, opts);
% extract x' and y' from solution
x = r(:,1);
y = r(:,2);

hold on
% plot the trajectory in x=r cos(theta) and y=r sin(theta)
plot(x,y,'r', 'DisplayName', 'Class 1');

xlabel('x''');
ylabel('y''');
%title(sprintf('%0.3f',pi));
% ------------------------
% get other class of stable orbits as well
ind = 4;
t = [stable_fine2(1,ind);stable_fine2(3,ind)];
% set a range of initial conditions [x, y, xdot, ydot]
ic=[t(1);0;0;t(end)];
% solve ode 
[t,r] = ode45(@(t,y) odefun(t,y,w,star_pos), tspan, ic, opts);
x1 = r(:,1);
y1 = r(:,2);
plot(x1,y1,'b','DisplayName', 'Class 2');
plot(star_pos(1,:),star_pos(2,:),'ro', 'DisplayName', 'Stars'); % position of stars


% plot(x1(1), y1(1), 'gx'); % initial position
% plot(x1(end), y1(end), 'bx'); % final position
legend()
grid on
axis equal 
hold off
%end
