function visualizacion_splines_fx(x, f)
    spline = function_cubic_spline(x, f(x));

    x = min(x)-0.2 : 1e-3 : max(x)+0.2;

    figure;
    plot(x, f(x), '--');
    hold on;
    plot(x, spline(x));
    scatter(x, f(x), 'filled');
    legend('Funcion', 'Interpolacion','Puntos dados', 'Location', 'best');
    grid on;
    title('Interpolacion de Splines cubicos');
    xlabel('x');
    ylabel('f(x)');
    hold off;
end