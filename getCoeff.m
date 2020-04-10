function [j, a, b] = getCoeff(num_left, num_right, num_down, num_up, num_cent, type_cent, cl_cent)
% Paramètres :
%   num_xxx : le numero du noeud xxx
%   type_cent : le type de maille centrale : 0 = hors domaine de calcul, 
%                                            1 = noeud de calcul entoure de
%                                                noeuds de calcul ou
%                                                condition limite
%                                            2 = noeud condition limite de
%                                                Dirichlet
%   cl_cent : l'eventuelle valeur de condition limite à prendre par ce
%             noeud
%
% Sortie :
%   a : le vecteur colonne de coefficients (~= 0) de l'équation du noeud
%       central dans le systeme lineaire a resoudre
%   j : le vecteur colonne contenant les numéros de colonnes des
%       coefficients contenus dans a
%   b : b la valeur du terme de droite de l'équation.

    % Hors-domaine de calcul, aucun coeff.
    if type_cent == 0
        a = [];
        j = [];
        b = 0;
    end

    % Noeud de calcul.
    if type_cent == 1
        a = [1; 1; 1; 1; -4];
        j = [num_right; num_left; num_up; num_down; num_cent];
        b = 0;
    end

    % Noeud de condition limite de Dirichlet.
    if type_cent == 2
        a = 1;
        j = num_cent;
        b = cl_cent;
    end
end