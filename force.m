function [fx,fy] = force(p,x,y)
% Entr»es : p = vecteur colonne des pressions
%          x = vecteur colonne des coordonn»es x 
%          y = vecteur colonne des coordonn»es y 
% Sortie : fx et fy = force par unit» d'»paisseur selon x et y

fx = trapz(x,p);
fy = trapz(y,p);

end