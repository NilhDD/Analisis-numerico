function [ts, ys] = visualizacion_met_taylor(f, dfs, alpha, a, b, n)
    [ts, ys] = metodo_taylor(f, dfs, alpha, a, b, n);

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'Taylor (aprox.)'); 
    hold on;
    
    title("Metodo de Taylor con n="+n);
    xlabel('t (variable independiente)');
    ylabel('y(t)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end