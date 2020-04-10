[stream, speed, press, dom, h] = main(2);

% Grille des coordonn�es pour dessiner en m�tres
[X, Y] = meshgrid(0:h:((size(stream, 1) - 1) * h), 0:h:((size(stream, 2) - 1) * h)); 
[X2, Y2] = meshgrid(0:h:((size(press, 1) - 1) * h), 0:h:((size(press, 2) - 1) * h)); 

stream_t = stream';
prandtl_contour = stream_t;
prandtl_contour(prandtl_contour < 0.235) = NaN;
prandtl_contour(prandtl_contour > 0.265) = NaN;
%prandtl_contour(~isnan(prandtl_contour)) = 1.4;

%stream_t(stream_t > 0.255) = NaN;
%stream_t(stream_t < 0.2) = NaN;

% Plot stream (Q2.1)
% figure(4);
% pcolor(X, Y, stream_t);
% hold on
% contour(X, Y, prandtl_contour, 1, 'red');
% title('Fonction de courant et Position du Tube de Prandtl', 'interpreter', 'latex');
% xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
% ylabel('Distance Verticale (m)', 'interpreter', 'latex');
% grid off
% shading interp
% c = colorbar('eastoutside');
% c.Label.String = 'Fonction de Courant';
% colormap jet
% hold off

% Plot isobare.
pression = press';
pression(stream_t <= 0.25) = NaN;

figure(3);
v = [-8000, -8000]
contour(X, Y, pression, v);
hold on
c = colorbar('eastoutside');
c.Label.String = 'Fonction de Courant';
contour(X, Y, prandtl_contour, 1, 'red');
title('Isobare et Tube de Prandtl', 'interpreter', 'latex');
xlabel('Distance Horizontale (m)', 'interpreter', 'latex');
ylabel('Distance Verticale (m)', 'interpreter', 'latex');
grid off
shading interp
colormap jet
hold off