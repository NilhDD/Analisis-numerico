function visualizacion_splines(x, y)
    scatter(x, y, 'filled');
    hold on;
    
    spline = function_cubic_spline(x, y);

    x = min(x)-0.5 : 1e-3 : max(x)+0.5;
    y = spline(x);

    plot(x, y);
    grid on;
end

