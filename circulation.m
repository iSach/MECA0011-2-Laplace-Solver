function [ circ ] = circulation(u,v,delta)
    x = length(u(3:end-2,end-2));
    %taille vecteur ligne end-2 allant de 3 à end-2
    y = length(v(3,3:end-2));
    %taille vecteur colonne 3 allant de 3 à end-2
    
    vectx = [delta:delta:(x*delta)];
    %reels de delta à x*delta avec un pas de delta
    vecty = [delta:delta:(y*delta)];
 
    circ = trapz(vecty,v(3,3:end-2)) + trapz(vectx,u(3:end-2,end-2)) - trapz(vecty,v(end-2,3:end-2)) - trapz(vectx,u(3:end-2,3));
    %integration de v en respect de X (v et X de mm longueur)
    %v(3,3:end-2) = ligne 3 de v, éléments 3 à end-2
end
