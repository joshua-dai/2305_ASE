function H = Hamiltonian(x,y,px,py,omega,star_pos)


% define separation vectors
xi = star_pos(1, :); % first row
yi = star_pos(2, :); % second row

sum_r = 0;

for n=1:3
    sum_r = sum_r + 1./sqrt((x-xi(n)).^2+(y-yi(n)).^2);
end
% px = xd - omega*y;
% py = yd + omega*x;

H = 1/2*(px.^2 + py.^2) + omega*y.*px - omega*x.*py - sum_r;
end