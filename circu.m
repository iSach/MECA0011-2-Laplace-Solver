function c=circu(u,v,x,y)
% Paramètres :
%   u : le vecteur des composantes horizontales de vitesse (classées selon
%       l'ordre de parcours des n?uds)
%   v : v le vecteur des composantes verticales de vitesse (classées selon
%       l'ordre de parcours des noeuds)
%   x : le vecteur de coordonnées x (classées selon l'ordre de parcours des
%       n?uds)
%   y : y le vecteur de coordonnées y (classées selon l'ordre de parcours
%       des n?uds)
%
% Renvoie :
%   c : la circulation

% Produit scalaire u * dy = 0 car u selon e_x. Pareil pour v * dx.
% On intègre alors u sur les x et v sur les y, et on additionne.

    c = trapz(x, u) + trapz(y, v);

end