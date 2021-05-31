
% create a grid from x in [-3,3], y in [-3,3]
square_ran = 2;
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

% plot the ranges
star_pos = [1, -1/2, -1/2;0, sqrt(3)/2, -sqrt(3)/2];

% plot the stars
for i=1:3
    circle(star_pos(1,i),star_pos(2,i), 0.6, 'r', 1.5); % LB
    circle(star_pos(1,i),star_pos(2,i), 1, 'g', 1.5); % UB
end
axis equal 
xlabel('$x\prime$', 'interpreter', 'latex')
ylabel('$y\prime$', 'interpreter', 'latex')
hold off

