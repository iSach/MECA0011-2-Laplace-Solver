function graphiques(which)
[stream, speed, press, ~, h] = main(which);

% Grille des coordonn�es pour dessiner en m�tres
[X, Y] = meshgrid(0:h:((size(stream, 1) - 1) * h), 0:h:((size(stream, 2) - 1) * h));

% Plot stream
figure(4);
pcolor(X, Y, stream');
hold on
title('Fonction de courant', 'interpreter', 'latex');
xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
ylabel('Distance Verticale (m)', 'interpreter', 'latex');
grid off
shading interp
c = colorbar('eastoutside');
c.Label.String = 'Fonction de Courant';
colormap jet
hold off

% Plot speed
figure(3);
pcolor(X, Y, speed');
hold on
title('Vitesse', 'interpreter', 'latex');
xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
ylabel('Distance Verticale (m)', 'interpreter', 'latex');
grid off
shading interp
c = colorbar('eastoutside');
c.Label.String = 'Vitesse';
colormap jet
hold off

press_t = press';
press_t(stream' <= 0.25) = NaN;
% Plot pression
figure(2);
pcolor(X, Y, press_t);
hold on
title('Pression', 'interpreter', 'latex');
xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
ylabel('Distance Verticale (m)', 'interpreter', 'latex');
grid off
shading interp
c = colorbar('eastoutside');
c.Label.String = 'Pression';
colormap winter
hold off
end