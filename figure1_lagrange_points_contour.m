
% create a grid from x in [-3,3], y in [-3,3]
square_ran = 3;
x = linspace(-square_ran,square_ran,300);
y = linspace(-square_ran,square_ran,300);
[X,Y] = meshgrid(x,y);

% compute the potential V
V = u(X,Y);
figure;
    
hold on
% plot V, linspace(-3,-1,100) means we only show values in [-3, -1] with
% 100 contour steps
contourf(x,y,V, linspace(-4,-1,100));

% plot lagrange points. only works after running lp_solver.m
scatter(l_points(1,:),l_points(2,:),100, 'red','x', 'LineWidth', 1.5)


axis equal 
xlabel('$x\prime$', 'interpreter', 'latex')
ylabel('$y\prime$', 'interpreter', 'latex')
%surf(x, y, V)
%zlim([-5 -1])
hold off
% Find Lagrange point from gradV=0, given some initial guess

% x = fsolve(@vfun,[0.03, 1.7])
