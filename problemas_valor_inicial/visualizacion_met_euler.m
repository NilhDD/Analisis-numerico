function visualizacion_met_euler(f, alpha, a, b, n)
    [ts, ys] = metodo_euler(f, alpha, a, b, n);

    sol = @(t) (t+1).^2 - 0.5 .* exp(t);
    xs = a:1e-3:b;

    figure;
    plot(ts, ys, 'LineWidth', 1, 'DisplayName', 'Euler (aprox.)'); 
    hold on;
    
    plot(xs, sol(xs), 'LineWidth', 1, 'DisplayName', 'Solución exacta');
    
    title('Método de Euler vs Solución Exacta');
    xlabel('t (variable independiente)');
    ylabel('y(t) (solución)');
    legend('Location', 'best');
    grid on;
    
    hold off;
end
