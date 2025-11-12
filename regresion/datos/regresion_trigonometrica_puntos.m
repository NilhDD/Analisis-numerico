function funcs = regresion_trigonometrica_puntos(x, y)
    %x:     vector columna de valores de x entre -pi y pi, debe ser par
    %y:     vector columna de valores de y, debe ser par

    %funcs: funciones aproximadas de grado n de la forma
    %Sn(x) = a0/2 + an*cos(n*x) + sum_{k=1}^{n-1}{ak*cos(k*x)+bk*sin(k*x)}

    j = length(x);
    m = j/2;

    a = zeros(m+1, 1);
    b = zeros(m+1, 1);

    for k = 0:m
        a(k+1) = (1/m) * sum(y .* cos(k*x));
        if k ~= m
            b(k+1) = (1/m) * sum(y .* sin(k*x));
        end
    end

    % Construir funciones parciales
    funcs = cell(m+1, 1);
    for n = 0:m
        funcs{n+1} = @(t) a(1)/2 + ...
            (a(2:n+1)' * cos((1:n)' * t)) + ...
            (b(2:n+1)' * sin((1:n)' * t));
    end
end