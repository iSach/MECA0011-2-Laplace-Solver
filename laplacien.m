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