function [ts, ys] = visualizacion_met_rk2(f, alpha, a, b, n)
    [ts, ys] = metodo_rk2(f, alpha, a, b, n);

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'RK2 (aprox.)'); 
    hold on;
    
    title("Metodo de RK2 con n="+n);
    xlabel('t (variable independiente)');
    ylabel('y(t)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end