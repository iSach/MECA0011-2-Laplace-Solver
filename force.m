function [fx,fy] = force(p,x,y)
% Entrees : p = vecteur colonne des pressions
%           x = vecteur colonne des coordonnees x 
%           y = vecteur colonne des coordonnees y 
%
% Sortie : fx et fy = force par unite d'epaisseur selon x et y

    fx = trapz(x,p);
    fy = trapz(y,p);

end