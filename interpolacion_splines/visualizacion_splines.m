function visualizacion_splines(xs, ys)
    spline = function_cubic_spline(xs, ys);

    x = min(xs)-0.5 : 1e-3 : max(xs)+0.5;
    y = spline(x);

    figure;
    plot(x, y);
    hold on;
    scatter(xs, ys, 'filled');
    legend('Interpolacion','Puntos dados', 'Location', 'best');
    grid on;
    hold off;
end

