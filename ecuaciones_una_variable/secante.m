function p = secante(f, p0, p1, TOL, N)
    %grafica
    xi = p0 - 2 : 1e-3 : p1 + 2;
    y = f(xi);
    plot(xi, y);
    grid on;


    %inicialización de variables
    i = 2;
    q0 = f(p0);
    q1 = f(p1);
    
    while i <= N
        %calculo de la aproximacion
        p = p1 - q1 * ((p1 - p0) / (q1 - q0));
        
        %condición de parada
        if abs(p - p1) < TOL
            fprintf('La raíz aproximada es: %.5f después de %d iteraciones.', p, i);
            return
        end
        
        %actualizar contador
        i = i + 1;
        
        %actualización de variables
        p0 = p1;
        q0 = q1;
        p1 = p;
        q1 = f(p);
    end
    
    fprintf('El método falló después de %d iteraciones, N0 = %d.\n', N, N);
    
    end
