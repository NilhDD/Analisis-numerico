function val = calculo_area_superficie_fast(X, Y, Z)

    % malla
    N = 200;   % aumentar = más preciso, pero más lento
    h = 1/N;
    
    % paso para derivadas
    hd = 1e-4;

    % Derivadas centradas
    du = @(f,u,v) ( f(u+hd,v) - f(u-hd,v) ) / (2*hd);
    dv = @(f,u,v) ( f(u,v+hd) - f(u,v-hd) ) / (2*hd);

    area = 0;

    for i = 1:N
        for j = 1:N
            u = (i-0.5)/N;
            v = (j-0.5)/N;

            % Derivadas
            Xu = du(X,u,v);   Xv = dv(X,u,v);
            Yu = du(Y,u,v);   Yv = dv(Y,u,v);
            Zu = du(Z,u,v);   Zv = dv(Z,u,v);

            % elemento de área
            c1 = Yu * Zv - Zu * Yv;
            c2 = Zu * Xv - Xu * Zv;
            c3 = Xu * Yv - Yu * Xv;

            dA = sqrt(c1*c1 + c2*c2 + c3*c3);

            area = area + dA;
        end
    end

    val = area * h * h;
end
