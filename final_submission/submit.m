function [psi,u,v] = submit(which)
% Charge les donnees et realise les differents calculs.
%
% Parametres :
%   which : cas a traiter.
%               1 = Canal Rectiligne
%               2 = Superposition d'un ecoulement uniforme a une source
%               3 = Ilot dans un écoulement (CL 1)
%               4 = Ilot dans un écoulement (CL 2)
%
% Sortie :
%   psi : La fonction de courant
%   u   : Composantes horizontales de vitesse (selon x).
%   v   : Composantes verticales de vitesse (selon y).

    switch which
        case 1
            h = 0.5;
        case 2
            h = 0.001;
        case {3, 4}
            h = 0.01;
    end

    dom = dlmread([num2str(which) '-dom.txt'], '\t');
    num = dlmread([num2str(which) '-num.txt'], '\t');
    cl = dlmread([num2str(which) '-cl.txt'], '\t');

    % Fonction de courant
    psi = laplacien(dom, num, cl);

    % Vitesse
    [u, v, ~] = velocity(psi, dom, h);
end

function psi = laplacien(dom, num, cl)
% Resout entierement le Laplacien.
%
% Entree :
%   * step : Distance entre deux noeuds.
%   * dom  : Matrice a type de chaque noeud.
%   * nul  : Matrice avec le numero de chaque noeud.
%   * cl   : Matrice avec la condition limite eventuelle de chaque noeud.
%
% Sortie :
%   * psi : Solution du Laplacien. Matrice qui contient la valeur de la
%            fonction de courant a chaque noeud (i, j) dans le domaine.

    nodes_nbr = max(max(num)); % Nombre de noeuds. Simplement le max de num
    s = size(num); % Dimensions de num, du domaine.
    height = s(1); % Nombre de lignes.
    width = s(2);  % Nombre de colonnes.

    % On accumule ici les données qu'on va introduire dans A et b.
    rows = []; % Contient les colonnes pour coeffs.
    cols = []; % Contient les colonnes pour coeffs.
    coeffs = []; % Contient les coefficients à mettre dans A.
    b_indices = []; % Contient les indices des lignes pour b.
    b_val = []; % Contient les termes indépendants à mettre dans b.

    % Remplir A et b.
    for i = 1 : height % lignes
        for j = 1 : width % colonnes
            if dom(i, j) == 0
                continue
            end
        
            num_left = num(i-1, j);
            num_right = num(i+1, j);
            num_down = num(i, j-1);
            num_up = num(i, j+1);
            num_cent = num(i, j);
            type_cent = dom(i, j);
            cl_cent = cl(i, j);
        
            [new_cols, new_coeffs, new_b] = getCoeff(num_left, ...
                num_right, num_down, num_up, num_cent, type_cent, cl_cent);

            rows = [rows; repmat(num_cent, size(new_cols, 1), 1)];
            cols = [cols; new_cols];
            coeffs = [coeffs; new_coeffs];
        
            if  new_b ~= 0
                b_indices = [b_indices; num_cent];
                b_val = [b_val; new_b];
            end
        end
    end

    % Matrice de coefficients des noeuds.
    A = sparse(rows, cols, coeffs, nodes_nbr, nodes_nbr);
    % Termes independants (vecteur colonne).
    b = sparse(b_indices, ones(size(b_val, 1), 1), b_val, nodes_nbr, 1);

    % Solution temporaire de psi (vecteur colonne) avant de convertir
    % en matrice pour replacer dans le domaine.
    vec_psi = A \ b;

    % Convertir vec_psi en matrice du domaine avec la valeur de psi à chaque
    % noeud.
    psi = NaN(height, width); % NaN pour les noeuds 0.
    for i = 1 : height
        for j = 1 : width
            if dom(i, j) ~= 0
                psi(i, j) = vec_psi(num(i, j));
            end
        end
    end
end

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

function [u, v, speed] = velocity(psi,dom,h)
% speed = vitesse resultante

% Calculs des vitesses aux differents noeuds
% m : nombres de lignes
% n : nombres de colonnes 

    [m,n] = size(dom);
    u = NaN(m, n);
    v = NaN(m, n);
    speed = NaN(m, n);

    for i = 1:m
        for j = 1:n
            if dom(i,j) ~= 0  
                % On utilise la fonction deriv car u = d(psi)/dy
                % Et v = -d(psi)/dx
                u(i,j) = deriv (psi(i,j-1), psi(i,j), psi(i,j+1), ...
                    dom(i,j-1), dom(i,j), dom(i,j+1), h);
                v(i,j) = -deriv (psi(i-1,j), psi(i,j), psi(i+1,j), ...
                    dom(i-1,j), dom(i,j), dom(i+1,j), h);
                speed(i,j) = sqrt((u(i,j)^2 + v(i,j)^2));
            end 
        end
    end
end

function v = deriv(f_left, f_c, f_right, type_left, type_c, type_right, h)
%Parametres : 
%   f_xxx    : la valeur de la fonction a deriver, a gauche, a droite, ...
%   type_xxx : le type de noeud : 0 = hors domaine de calcul, 
%                                 1 = noeud de calcul
%                                 2 = noeud condition limite de
%                                     Dirichlet 
%   h        : pas spatial entre deux noeuds  
    
    % Hors dommaine de calcul 
    if type_c == 0
        v = 0;
    
    % Noeud de calcul
    elseif type_c == 1
        v = (f_right-f_left)/(2*h);
     
    % Noeud condition limite avec tous les cas possibles 
    % (depend du type de bord sur lequel on se trouve)
    elseif type_c == 2
        if type_left == 0
            v = (f_right - f_c)/h;
        
        elseif type_right == 0
            v = (f_c - f_left)/h;
        else
            v = (f_left-f_right)/(2*h);
        end
    end   
end