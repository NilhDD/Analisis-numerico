function [ts, ys] = visualizacion_met_euler(f, alpha, a, b, n)
    [ts, ys] = metodo_euler(f, alpha, a, b, n);
    
    xs = a:1e-3:b;

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'Euler (aprox.)'); 
    hold on;
    title('Método de Euler');
    xlabel('t (variable independiente)');
    ylabel('y(t) (solución)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end
