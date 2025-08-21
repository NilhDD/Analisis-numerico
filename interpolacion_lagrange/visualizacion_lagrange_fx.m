function visualizacion_lagrange_fx(xs, f)    
    coefi = coeficientes_lagrange(xs, f(xs));
    n = length(xs);

    p = @(x) 0;

    for i = 1:length(coefi)
        p = @(x) p(x) + coefi(i).*x.^(n-i);
    end

    disp(coefi);

    x = min(xs)-0.5 : 1e-3 : max(xs)+0.5;

    figure;
    plot(x, f(x), '--');
    hold on;
    plot(x, p(x));
    scatter(xs, f(xs), 'filled');
    legend('Funcion', 'Interpolacion','Puntos dados', 'Location', 'best');
    grid on;
    title('Interpolacion de Lagrange');
    xlabel('x');
    ylabel('f(x)');
    hold off;
end