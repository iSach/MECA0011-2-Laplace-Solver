function p = pressure(speed, dom, C)
% Entr�es : speed = r�sultante des composantes de vitesse hor. et vert.
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
            p(i,j) = rho * g * (C - ((speed(i, j))^2) / (2 * g));
        end
    end
end
