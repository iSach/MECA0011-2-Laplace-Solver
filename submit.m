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