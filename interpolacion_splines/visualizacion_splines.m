function visualizacion_splines(x, y)
    spline = function_cubic_spline(x, y);

    x = min(x)-0.5 : 1e-3 : max(x)+0.5;
    y = spline(x);

    figure;
    plot(x, y);
    hold on;
    scatter(x, y, 'filled');
    legend('Interpolacion','Puntos dados', 'Location', 'best');
    grid on;
    hold off;
end

