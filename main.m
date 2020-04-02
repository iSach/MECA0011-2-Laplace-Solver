function main(which)
% Charge les donnees et realise les differents calculs.
%
% Parametres :
%   which : cas a traiter.
%               1 = Canal Rectiligne
%               2 = Superposition d'un ecoulement uniforme a une source
%               3 = Ilot dans un �coulement (CL 1)
%               4 = Ilot dans un �coulement (CL 2)
switch which
    case 1
        h = 0.5;
    case 2
        h = 0.001;
    case {3, 4}
        h = 0.01;
end

dom = dlmread(strcat(num2str(which), '-dom.txt'), '\t');
num = dlmread(strcat(num2str(which), '-num.txt'), '\t');
cl = dlmread(strcat(num2str(which), '-cl.txt'), '\t');

psi = laplacien(dom, num, cl);

% a faire...

end 