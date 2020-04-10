function c=circu(u,v,x,y)
% Param�tres :
%   u : le vecteur des composantes horizontales de vitesse (class�es selon
%       l'ordre de parcours des n?uds)
%   v : v le vecteur des composantes verticales de vitesse (class�es selon
%       l'ordre de parcours des noeuds)
%   x : le vecteur de coordonn�es x (class�es selon l'ordre de parcours des
%       n?uds)
%   y : y le vecteur de coordonn�es y (class�es selon l'ordre de parcours
%       des n?uds)
%
% Renvoie :
%   c : la circulation

% Produit scalaire u * dy = 0 car u selon e_x. Pareil pour v * dx.
% On int�gre alors u sur les x et v sur les y, et on additionne.

    c = trapz(x, u) + trapz(y, v);

end