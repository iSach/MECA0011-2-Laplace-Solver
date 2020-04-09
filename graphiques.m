function graphiques(which)
[stream, speed, press, h] = main(which);

% Grille des coordonnées pour dessiner en mètres
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

% Plot pression
figure(2);
pcolor(X, Y, press');
hold on
title('Pression', 'interpreter', 'latex');
xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
ylabel('Distance Verticale (m)', 'interpreter', 'latex');
grid off
shading interp
c = colorbar('eastoutside');
c.Label.String = 'Pression';
colormap jet
hold off
end