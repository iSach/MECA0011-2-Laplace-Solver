function [ trainee, portance ] = trainee_portance( p, delta )
    %Calcul de la r?sultante des force sur chaque face.
    %Les nombres sont les coordonn?es des sommets de l'ilots
    Fsup = sum(p(91,17:37) * delta);
    Finf = sum(p(113, 17:37) * delta);
    Fdroite = sum(p(92:112,38) * delta);
    Fgauche = sum(p(92:112,16) * delta);
   
    portance = Fgauche - Fdroite;
    trainee = Finf - Fsup;
end
