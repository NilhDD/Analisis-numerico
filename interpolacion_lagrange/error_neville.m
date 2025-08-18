function error_neville(xi, yi)
    coefi = coeficientes_lagrange(xi, yi);
    n = length(xi);

    p = @(x) 0;

    for i = 1:length(coefi)
        p = @(x) p(x) + coefi(i).*x.^(n-i);
    end

    x = min(xi)-0.5 : 1e-3 : max(xi)+0.5;
    y = p(x);
    ne = zeros(length(x));
    error = zeros(length(x));

    for elemento = 1:length(x)
        neville = algoritmo_neville(xi, yi, x(elemento), n-1);
        ne(elemento) = neville(1,n);
        error(elemento) = y(elemento) - ne(elemento);
    end

    plot(x, error);
    legend('Diferencia entre Lagrange y Neville', 'Location', 'best');
    grid on;
end

