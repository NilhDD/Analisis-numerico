function [ts, ys] = visualizacion_met_k2(f, alpha, a, b, n)
    [ts, ys] = metodo_k2(f, alpha, a, b, n);

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'Euler (aprox.)'); 
    hold on;
    
    title("Metodo de K2 con n="+n);
    xlabel('t (variable independiente)');
    ylabel('y(t)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end