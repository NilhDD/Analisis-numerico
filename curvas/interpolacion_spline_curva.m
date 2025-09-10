function [Sx, Sy] = interpolacion_spline_curva(xs, ys)
    xs = [xs, xs(1)];
    ys = [ys, ys(1)];
    
    %normalizar entre 0 y 1
    t = [0; cumsum(sqrt(diff(xs(:)).^2 + diff(ys(:)).^2))];
    t = t / t(end);
    
    %construir splines parametricos
    Sx = function_cubic_spline(t, xs);
    Sy = function_cubic_spline(t, ys);
    

    tt = 0:1e-6:1;
    xx = Sx(tt);
    yy = Sy(tt);
    
    figure;
    plot(xx, yy, 'b-', 'LineWidth', 2);
    hold on;
    scatter(xs, ys, 'r', 'filled');
    title('Borde interpolado con splines cúbicos');
    grid on;
    hold off;
end