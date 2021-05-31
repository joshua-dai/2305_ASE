% find all unique lagrange points in (-3,3)x(-3,3) grid
sols = zeros(200, 200,2);
x_arr = linspace(-3,3,150);
y_arr = linspace(-3,3,150);
options = optimset('Display', 'off');
for n=1:numel(x_arr)
    for m=1:numel(y_arr)
        x = fsolve(@vfun,[x_arr(n), y_arr(m)], options);
        sols(m,n,1) = x(1);
        sols(m,n,2) = x(2);
    end
end

% find unique vectors

tol = 1e-3;
l_points = [0;0];
for i=1:numel(x_arr)
    for j=1:numel(y_arr)
        test_sol = reshape(sols(i,j,:),[2,1]);
        add_bool = 1; % by default add 
        for p=1:numel(l_points(1,:))
            if norm(l_points(:,p)-test_sol)<tol
                add_bool = 0; % if within tol don't add
            end
        end
        if add_bool ==1
           l_points = [l_points test_sol];
        end
    end
end
