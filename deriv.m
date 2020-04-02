function v = deriv(f_left, f_c, f_right, type_left, type_c, type_right, h)
%ParamËtres : 
%   f_xxx : la valeur de la fonction ? dÈriver, ? gauche, ? droite, ...
%   type_xxx : le type de noeud : 0 = hors domaine de calcul, 
%                                 1 = núud de calcul entourÈ de
%                                     núuds de calcul ou
%                                     condition limite
%                                 2 = núud condition limite de
%                                     Dirichlet 
%   h : pas spatial entre deux noeuds  
    
    %Hors dommaine de calcul 
    if type_c == 0
        v = 0;
    
    
    %Noeud de calcul
    elseif type_c == 1
        v = (f_right-f_left)/(2*h);
    
    
    %Noeud condition limite avec tous les cas possibles 
    %(dÈpend du type de bord sur lequel on se trouve)
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