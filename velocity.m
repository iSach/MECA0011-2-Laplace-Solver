function [u, v, speed] = velocity(psi,dom,h)
% speed = vitesse resultante

% Calculs des vitesses aux differents noeuds
% m : nombres de lignes
% n : nombres de colonnes 

    [m,n] = size(dom);
    u = NaN(m, n);
    v = NaN(m, n);
    speed = NaN(m, n);

    for i = 1:m
        for j = 1:n
            if dom(i,j) ~= 0  
                % On utilise la fonction deriv car u = d(psi)/dy
                % Et v = -d(psi)/dx
                u(i,j) = deriv (psi(i,j-1), psi(i,j), psi(i,j+1), ...
                    dom(i,j-1), dom(i,j), dom(i,j+1), h);

                v(i,j) = -deriv (psi(i-1,j), psi(i,j), psi(i+1,j), ...
                    dom(i-1,j), dom(i,j), dom(i+1,j), h);

                speed(i,j) = sqrt((u(i,j)^2 + v(i,j)^2));
            end 
        end
    end
end