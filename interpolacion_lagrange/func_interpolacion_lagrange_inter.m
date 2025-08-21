function func = func_interpolacion_lagrange_inter(xs, ys)
    [a,b,c,d] = coeficientes_lagrange_inter(xs, ys);
    func = @(x) lagrange_intervalos(xs,a,b,c,d,x);
end

function value = lagrange_intervalos(xs, a, b, c, d, x)
    n = length(xs);
    if x <= xs(2)
        j = 1;
    elseif xs(n-1) <= x
        j = n-1;
    else
        for i = 2:n-2
            if (xs(i) <= x) && (x < xs(i+1))
                j = i;
            end
        end
    end

    funcion = @(x) a(j).*x.^3 + b(j).*x.^2 + c(j).*x + d(j);
    value = funcion(x);
end

function [a,b,c,d] = coeficientes_lagrange_inter(xs, ys)
    %Se calculas los coeficientes de lagrange de orden cubico para
    %aproximarla funcion por intervalos, donde el valor de f(x) depende del
    %intervalo donde pertenece x.
    %Se necesita que los valores de x esten ordenados

    %validacion de entradas
    if length(xs) ~= length(ys)
        fprintf('Los vectores de entrada x e y deben tener la misma longitud.');
        return
    end

    n = length(xs);

    a = zeros(1, n-1);
    b = zeros(1, n-1);
    c = zeros(1, n-1);
    d = zeros(1, n-1);

    coef = coeficientes_lagrange(xs(1:3), ys(1:3));
    [b(1), c(1), d(1)] = deal(coef(1), coef(2), coef(3));

    coef = coeficientes_lagrange(xs(n-2:n), ys(n-2:n));
    [b(n-1), c(n-1), d(n-1)] = deal(coef(1), coef(2), coef(3));


    for i = 2:n-2
        coef = coeficientes_lagrange(xs(i-1:i+2), ys(i-1:i+2));
        [a(i), b(i), c(i), d(i)] = deal(coef(1), coef(2), coef(3), coef(4));
    end
end