function visualizacion_lagrange_xy(x, y)
    scatter(x, y, 'filled');
    hold on;
    
    coefi = coeficientes_lagrange(x, y);
    n = length(x);

    p = @(x) 0;

    for i = 1:length(coefi)
        p = @(x) p(x) + coefi(i).*x.^(n-i);
    end

    disp(coefi);

    x = min(x)-0.5 : 1e-3 : max(x)+0.5;
    y = p(x);

    plot(x, y);
    grid on;
end