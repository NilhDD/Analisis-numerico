function [ts, ys] = visualizacion_met_rk4(f, alpha, a, b, n)
    [ts, ys] = metodo_rk4(f, alpha, a, b, n);

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'RK4 (aprox.)'); 
    hold on;
    
    title("Metodo de RK4 con n="+n);
    xlabel('t (variable independiente)');
    ylabel('y(t)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end