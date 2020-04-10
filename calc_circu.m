% Coins Rectangle : (91, 16) -> (113, 38)
x1 = 91;
y1 = 16;
x2 = 113;
y2 = 38;


h = 0.01;
x_indices = [x1:x2, x2:-1:x1]; % indices parcours sur x.
y_indices = [y1:y2, y2:-1:y1]; % indices parcours sur y.
x = zeros(size(x_indices)); % Coordonnées x
y = zeros(size(y_indices)); % Coordonnées y
for i=1:size(x_indices, 2)
    x(i)=(x_indices(i)-1) * h;
end
for i=1:size(y_indices, 2)
    y(i)=(y_indices(i)-1) * h;
end

% Ilot 1
[~, u, v, ~, ~, ~] = main(3);
u1 = [];
v1 = [];
%
% côté droit :
% |
% v
% |
%
for i = x1:x2
    u1 = [u1; u(i, y2)];
end
% Côté bas 
% ---<----
for i = y2:-1:y1
    v1 = [v1; v(x2, i)];
end
%
% côté gauche :
% |
% ^
% |
for i = x2:-1:x1
    u1 = [u1; u(i, y1)];
end
% Côté haut 
% --->----
for i = y1:y2
    v1 = [v1; v(x1, i)];
end

c = circu(u1, v1, x, y);

disp(['Circu 1 = ' num2str(c)]);

% Ilot 2
[~, u, v, ~, ~, ~] = main(4);
u2 = [];
v2 = [];
for i = x1:x2
    u2 = [u2; u(i, y2)];
end
for i = x2:-1:x1
    u2 = [u2; u(i, y1)];
end
for i = y1:y2
    v2 = [v2; v(x1, i)];
end
for i = y2:-1:y1
    v2 = [v2; v(x2, i)];
end

c = circu(u2, v2, x, y);

disp(['Circu 2 = ' num2str(c)]);