figure
hold on

% the number of p2s we hope to explore
np2 = 70;
% the number of times for each orbit
nppts = 500;

% set the parameters 
w = (1/3)^(1/4);
star_pos = [1, -1/2, -1/2; 0, sqrt(3)/2, -sqrt(3)/2];
xi = star_pos(1, :); % first row
yi = star_pos(2, :); % second row


% set the time span
tspan = [0, 100];
% here we set both error
reltol = 1e-9;
abstol = 1e-9;

% generate ODE solving options
opts = odeset('RelTol',reltol,'AbsTol',abstol,'Events', @EventsFunc);

% initial conditions 
x0 = 1.73;
y0 = 0;
px0 = 0;
py0 = -1.6842+w*x0;

% define sum
sum_r = 0;
for n=1:3
    sum_r = sum_r + 1./sqrt((x0-xi(n)).^2+(y0-yi(n)).^2);
end
    
% The fixed value of Hamiltonian we are looking at
Hfixed = Hamiltonian(x0, y0, px0, py0, w, star_pos);

% create the parameter arrays
pylist = linspace(py0-0.25,py0+0.25, np2);%[py0]; %linspace(py0, py0+10, 10);
x0list = zeros(1,np2);

% fill in the correct x0 to get a fixed H
for i=1:numel(pylist)
    syms x0
    sum_r = 0;
    for n=1:3
        sum_r = sum_r + 1./sqrt((x0-xi(n)).^2+(y0-yi(n)).^2);
    end
    py0 = pylist(i);
    x0list(i) = double(vpasolve(1/2*(px0.^2 + py0.^2) + w*y0.*px0 - w*x0.*py0 - sum_r==Hfixed,x0, 1.9));
end

% solve the ODE nppts times
for i=1:numel(pylist)
    
    % get the initial conditions
    py0 = pylist(i);
    x0 = x0list(i);
    
    % set a range of initial conditions [x1,x2,p1,p2]
    ic=[x0;y0;px0;py0];
    
    % note that here py0 is always negative, so we don't need to worry
    % about root switching
    
    % add IC to plot
    pxplot(1) = px0;
    xplot(1) = x0;

    % now do the poincare mapping
    for j = 1:nppts
        [t,y, te, ye, ie] = ode45(@(t,y) odefun(t, y, w, star_pos), tspan, ic, opts);

        id = 1; % extract the subsequent timestep

        % extract the solution
        x1 = ye(id,1);
        x2 = ye(id,2);
        p1 = ye(id,3);
        p2 = ye(id,4);

        xplot(j+1) = x1;
        pxplot(j+1) = p1;
        
        % to save resources, if the current trajectory escapes plot ranges just stop
        if x1<1.6 || x1>1.85
            break
        end
        if p1<-0.4 || p1>0.4
            break
        end
        ic = [x1;x2;p1;p2]; 
        
    end

    scatter(xplot,pxplot,'.');

end



axis([1.6 1.85 -0.4 0.4]); % set plot limits to prevent too much zoom out
xlabel('x''');
ylabel('px''');


