function visualizacion_met_ridderes(f, x0, h, c, n)
    figure;
    xs = x0-5:1e-6:x0+5;
    plot(xs, f(xs));
    hold on;

    resultados = metodo_ridderes(f, x0, h, c, n);
    deri = resultados(1, end);
    tang = deri*(xs - x0) + f(x0);

    plot(xs, tang, '--');
    scatter(x0, f(x0), 'filled');
    legend('Funcion', 'Tangente', 'Punto', 'Location', 'best');
    title('Interpolacion de Lagrange');
    text(x0+1, f(x0), sprintf('y = %.3f x %+ .3f', deri, f(x0) - deri*x0), 'FontSize', 10, 'Color', 'r');
    xlabel('x');
    ylabel('y');
    grid on;
    hold off;
end

