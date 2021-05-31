% make sure to have l_points solved and stored in current workspace
% set the time span
tspan = [0, 50];
% set the relative error
reltol = 1e-9;
% generate ODE solving options
opts = odeset('RelTol',reltol);
% opts = odeset('AbsTol', reltol);
% omega is rotational speed of 3 stars
w = (1/3)^(1/4);

% give position of stars in their static frame
star_pos = [1, -1/2, -1/2;0, sqrt(3)/2, -sqrt(3)/2];

ha = tight_subplot(5, 2, [.05 0.001],.1,0.01); % nh, nw, gap, margin_h, margin_w
type = 'phase'; % phase or orbit plot

for p=1:numel(l_points(1,:)) % loop through all unique lagrange points
%subplot(5,2, p)
axes(ha(p))
% set a range of initial conditions [x, y, xdot, ydot]
ic=[l_points(1,p);l_points(2,p);0;0];

% solve the ODE

[t,r] = ode45(@(t,y) odefun(t,y,w,star_pos), tspan, ic, opts);
% extract x' and y' from solution
x = r(:,1);
y = r(:,2);

hold on
% plot the trajectory in x=r cos(theta) and y=r sin(theta)
plot(x,y);
plot(star_pos(1,:),star_pos(2,:),'ro'); % position of stars
plot(x(1), y(1), 'go'); % initial position
plot(x(end), y(end), 'bo'); % final position
title(sprintf('x=%1.4f, y=%1.4f',ic(1),ic(2)))
xlabel('x''');
ylabel('y''');
%title(sprintf('%0.3f',pi));
grid on
axis equal 
hold off

end 
set(ha(1:4),'XTickLabel',''); 
set(ha,'YTickLabel','') % add back labels