function p = pressure(u, v, dom, C)
% Entr�es : u = vecteur des composantes horizontales de vitesse
%           v = vecteur des composantes verticales de vitesse
%           dom = matrice sur laquelle on travaille
%           C = constante � fixer arbitrairement

% Sortie = vecteur des pressions aux diff�rents noeuds


    % Fixation des constantes rho et g, et initialisation des fonctions �
    % calculer
    rho = 1000;
    g = 9.81;
    [nb_rows,nb_columns] = size(dom);
    p = zeros(nb_rows,nb_columns);
    
    % Calcul des fonctions pour chaque noeud 
    for i = 1:nb_rows
        for j = 1:nb_columns
            velocity = sqrt((u(i,j))^2 + (v(i,j)^2));
            p(i,j) = rho*g *(C - (velocity^2)/(2*g));
        end
    end
end
