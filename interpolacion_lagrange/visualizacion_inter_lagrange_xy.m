function visualizacion_inter_lagrange_xy(xs, ys)
    p = func_interpolacion_lagrange_inter(xs, ys);

    x = min(xs)-0.5 : 1e-3 : max(xs)+0.5;
    y = zeros(1, length(x));

    for i = 1:length(x)
        y(i) = p(x(i));
    end

    figure;
    plot(x, y);
    hold on;
    scatter(xs, ys, 'filled');
    legend('Interpolacion', 'Puntos dados', 'Location', 'best');
    grid on;
    title('Interpolacion de Lgrange por intervalos');
    xlabel('x');
    ylabel('y');
    hold off;
end