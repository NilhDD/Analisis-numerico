function visualizacion_inter_lagrange_fx(xs, f)
    ys = f(xs);
    p = func_interpolacion_lagrange_inter(xs, ys);

    x = min(xs)-0.5 : 1e-3 : max(xs)+0.5;
    y = zeros(1, length(x));

    for i = 1:length(x)
        y(i) = p(x(i));
    end

    figure;
    plot(x, f(x),  '--');
    hold on;
    plot(x, y);
    scatter(xs, ys, 'filled');
    legend('Funcion', 'Interpolacion', 'Puntos dados', 'Location', 'best');
    grid on;
    title('Interpolacion de Lgrange por intervalos');
    xlabel('x');
    ylabel('f(x)');
    hold off;
end