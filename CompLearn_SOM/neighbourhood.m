function neigh = neighbourhood(m, i)
%%% neighbourhood function
% decreases linearly with distance from the winner

neigh = zeros(11,1);
for x = 1:11
    if(x<=i)
        neigh(x) = m*(x-i)+1;
    else
        neigh(x) = -m*(x-i)+1;
    end
end
neigh(neigh<0) = 0;

x = 1:11;
figure;
plot(x,neigh);
xlabel('Output Unit'); ylabel('Neighbourhood function');
title(['Neighbourhood Function - Slope = ', num2str(m)]);

end
