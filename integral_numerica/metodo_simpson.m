function value = metodo_simpson(f, a, b, n)
    %Se calcula la integral de f entre a y b, dividiendo el
    %intervalo en n partes, donde n es un numero par usando
    %el metodo de Simpson compuesto

    %inicializar las variables
    if mod(n,2) ~= 0
        n = n + 1;
    end

    h = (b - a) / n;
    xl1 = 0;
    xl2 = 0;

    %calcular las sumatorias
    for i = 1:n-1
        x = a + i*h;
        if mod(i, 2) == 0
            xl2 = xl2 + f(x);
        else
            xl1 = xl1 + f(x);
        end
    end

    %hacer la operacion de los f pares, impares y los extremos
    value = (h/3) * (f(a) + f(b) + 4*xl1 + 2*xl2);
end