function visualizacion_lagrange_xy(xs, ys)   
    coefi = coeficientes_lagrange(xs, ys);
    n = length(xs);

    p = @(x) 0;

    for i = 1:length(coefi)
        p = @(x) p(x) + coefi(i).*x.^(n-i);
    end

    disp(coefi);

    x = min(xs)-0.5 : 1e-3 : max(xs)+0.5;
    y = p(x);

    figure;
    plot(x, y);
    hold on;
    scatter(xs, ys, 'filled');
    legend('Interpolacion','Puntos dados', 'Location', 'best');
    grid on;
    xlabel('x');
    ylabel('y');
    hold off;
end