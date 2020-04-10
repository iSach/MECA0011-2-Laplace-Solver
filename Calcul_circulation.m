function [circulation] = Calcul_circulation(psi)%(Cas_n,cl,dom,num,h)
        %ilot
    lig_ht=91;
    %lig_bs=113;
    col_gau=16;
    %col_dr=38;
    Cas_n = 4;
        %calculer circulation autour de l'ilot
    [stream, u, v, press, dom, h] = main(4);
    m=1;
    if (Cas_n==3 || Cas_n==4)
        while (col_gau<=38)
            x(m,1)=col_gau;
            y(m,1)=lig_ht;
            col_gau=col_gau+1;
            m=m+1;
        end
        col_gau=col_gau-1;
        m=m-1;
        while (lig_ht<=113)
            x(m,1)=col_gau;
            y(m,1)=lig_ht;
            lig_ht=lig_ht+1;
            m=m+1;
        end
        lig_ht=lig_ht-1;
        m=m-1;
        while (col_gau>=16)
            x(m,1)=col_gau;
            y(m,1)=lig_ht;
            col_gau=col_gau-1;
            m=m+1;
        end
        col_gau=col_gau+1;
        m=m-1;
        while (lig_ht>=91)
            x(m,1)=col_gau;
            y(m,1)=lig_ht;
            lig_ht=lig_ht-1;
            m=m+1;
        end
        u_vect=zeros(length(x), 1);
        v_vect=zeros(length(x), 1);
        i=1;
        while (i<=length(x))
            u_vect(i)=v(y(i), x(i));
            v_vect(i)=u(y(i), x(i));
        end
        x=x*h;
        y=y*h;
        circulation=circu(u_vect,v_vect,x,y);
    else
        circulation=0;
    end
end