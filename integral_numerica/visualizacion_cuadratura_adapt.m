function visualizacion_cuadratura_adapt(f, a, b, TOL, n)
    [sizes, ints] = cuadratura_adaptable(f, a, b, TOL, n);
    
    %reconstruir intervalos
    intervalos = zeros(length(sizes), 2);
    intervalos(1,1) = a;
    for i = 1:length(sizes)
        if i == 1
            intervalos(i,1) = a;
        else
            intervalos(i,1) = intervalos(i-1,2);
        end
        intervalos(i,2) = intervalos(i,1) + sizes(i);
    end
    

    xs = a-1:1e-6:b+1;
    ys = f(xs);
    
    figure;
    plot(xs, ys, 'b', 'LineWidth', 1.5);
    hold on;
    
    for i = 1:length(sizes)
        ai = intervalos(i,1);
        bi = intervalos(i,2);


        x_fill = linspace(ai, bi, 100);
        y_fill = f(x_fill);
        area(x_fill, y_fill, 'FaceColor', [0.9 0.8 1], 'EdgeColor', 'k');
        
        plot([bi bi], [0 f(bi)], 'k--');
    end
    
    title(sprintf('Cuadratura Adaptativa (Integral total: %.6f)', sum(ints)));
    xlabel('x');
    ylabel('y');
    grid on;
    hold off;
end