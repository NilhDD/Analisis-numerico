function [ts,yts] = metodo_disparo(f, a, b, alpha, beta, n)
    %f:             funcion f(t,y,y')
    % y'' = f(t,y,y'), y(a)=alpha, y(b)=beta
    %a, b:          extremos del intervalo
    %alpha, beta:   condicion inicial y(a)=alpha, y(b)=beta
    %n:             numero de paso
    
    %ts:            vector de valores independientes entre a, b
    %yts:           vector de valores y(t)

    %se transforma en un sistema de la forma z=y'
    %       y' = z = g(t,y,z)
    % y'' = z'     = f(t,y,z)

    F = {@(t,y) y(2), @(t,y) f(t,y(1),y(2))};
    
    %disparos iniciales
    z1 = 0; 
    z2 = 1;

    sol1 = sistemas_rk4(F, [alpha, z1], a, b, n);
    sol2 = sistemas_rk4(F, [alpha, z2], a, b, n);

    yb1 = sol1(end, 2);
    yb2 = sol2(end, 2);

    tol = 1e-6;
    iter = 0; maxiter = 20;

    while abs(yb2 - beta) > tol && iter < maxiter
        iter = iter + 1;

        zr = z2 - (yb2 - beta)*(z2 - z1)/(yb2 - yb1);

        solr = sistemas_rk4(F, [alpha, zr], a, b, n);
        ybr = solr(end, 2);

        %actualiza valores
        z1 = z2; yb1 = yb2;
        z2 = zr; yb2 = ybr;
    end

    ts  = solr(:, 1);
    yts = solr(:, 2);
end