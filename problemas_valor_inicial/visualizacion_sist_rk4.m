function w = visualizacion_sist_rk4(F, alpha, a, b, n)
    w = sistemas_rk4(F, alpha, a, b, n);

    m= length(alpha);
    for i = 2:m+1
        j = i-1;
        figure;
        plot(w(:,1), w(:,i), 'LineWidth', 1, 'DisplayName', 'RK4 (aprox.)'); 
        hold on;        
        title("Metodo de RK4 con n="+n+" y"+j+"(t)");
        xlabel('t (variable independiente)');
        ylabel("y"+j+"(t)");
        legend('Location', 'best');
        grid on;
        hold off;
    end
end