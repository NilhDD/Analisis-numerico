function val = calculo_area_superficie_fast(X, Y, Z)
    %X: funcion x de la parametrizacion de la superficie
    %Y: funcion y de la parametrizacion de la superficie
    %Z: funcion z de la parametrizacion de la superficie

    %val: aproximacion del area de la superficie
    %IMPORTANTE: como la interpolacion es un proceso tan largo se usan
    %mallas de numeros por que si se usa las formulas habituales se
    %demoraria demasiado tiempo

    % malla
    N = 300;
    h = 1/N;
    
    %paso para derivadas
    hd = 1e-4;

    %derivadas parciales centradas
    du = @(f,u,v) ( f(u+hd,v) - f(u-hd,v) ) / (2*hd);
    dv = @(f,u,v) ( f(u,v+hd) - f(u,v-hd) ) / (2*hd);

    area = 0;

    for i = 1:N
        for j = 1:N
            u = (i-0.5)/N;
            v = (j-0.5)/N;

            %derivadas
            Xu = du(X,u,v);   Xv = dv(X,u,v);
            Yu = du(Y,u,v);   Yv = dv(Y,u,v);
            Zu = du(Z,u,v);   Zv = dv(Z,u,v);

            %elemento de area
            c1 = Yu * Zv - Zu * Yv;
            c2 = Zu * Xv - Xu * Zv;
            c3 = Xu * Yv - Yu * Xv;

            dA = sqrt(c1*c1 + c2*c2 + c3*c3);

            area = area + dA;
        end
    end

    val = area * h * h;
end
