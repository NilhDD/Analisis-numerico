function B = metodo_gram_schmidt(phi0, w, a, b, n)
    %phi0:  funcion con la que el metodo empieza
    %w:     funcion de peso
    %%a, b: intervalo de la funcion
    %n:     cantidad de funciones a generar

    %B:         base ortogonal con respecto a w con n+1 elementos
    %IMPORTANTE: si phi0 no es polinomica la base no es de PIn, pero si se
    %garantiza la ortogonalidad con respecto a w

    B = cell(n+1, 1);
    B{1} = phi0;

    D = metodo_simpson(@(x) x*w(x)*phi0(x)^2, a, b, 500)/...
            metodo_simpson(@(x) w(x)*phi0(x)^2, a, b, 500);

    B{2} = @(x) (x - D).*B{1}(x);

    for i = 3:n+1
        phi1 = B{i-1};
        phi2 = B{i-2};
        D = metodo_simpson(@(x) x*w(x)*phi1(x)^2, a, b, 500)/...
            metodo_simpson(@(x) w(x)*phi1(x)^2, a, b, 500);

        C = metodo_simpson(@(x) x*w(x)*phi1(x)*phi2(x), a, b, 500)/...
            metodo_simpson(@(x) w(x)*phi2(x)^2, a, b, 500);

        B{i} = @(x) (x - D).*phi1(x) - C.*phi2(x);
    end
end