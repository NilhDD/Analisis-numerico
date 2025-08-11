function p = newton_raphson(f, df, p0, TOL, N)
    %grafica
    xi = p0 - 8 : 1e-3 : p0 + 2;
    y = f(xi);
    plot(xi, y);
    grid on;

    %inicializacion
    i = 1;
    p = p0;

    while i <= N
        %calcula la nueva aproximacion 
        p_new = p -f(p)/df(p);

        if abs(p_new -p) < TOL
            fprintf('La raíz aproximada es: %.5f después de %d iteraciones.', p_new, i);
            return
        end
        %actualiza i
        i = i + 1;
        p = p_new;
    end
    fprintf('El método falló después de %d iteraciones.\n', N);
end