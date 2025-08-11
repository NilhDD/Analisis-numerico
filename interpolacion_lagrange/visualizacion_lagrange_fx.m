function visualizacion_lagrange_fx(x, f)
    scatter(x, f(x), 'filled');
    hold on;
    
    coefi = coeficientes_lagrange(x, f(x));
    n = length(x);

    p = @(x) 0;

    for i = 1:length(coefi)
        p = @(x) p(x) + coefi(i).*x.^(n-i);
    end

    disp(coefi);

    x = min(x)-0.5 : 1e-3 : max(x)+0.5;

    plot(x, f(x), '--');
    plot(x, p(x));
    legend('Puntos dados', 'Funcion', 'Interpolacion', 'Location', 'best');
    grid on;
end