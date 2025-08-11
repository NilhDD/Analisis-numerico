function p = falsa_posicion(f, p0, p1, TOL, N)
    %grafica
    xi = p0 - 2 : 1e-3 : p1 + 2;
    y = f(xi);
    plot(xi, y);
    grid on;


    %inicializacion de variables
    i = 2;
    q0 = f(p0);
    q1 = f(p1);
    
    while i <= N
        %caculo de la nueva aproximacion
        p = p1 - q1 * (p1 - p0) / (q1 - q0);
        
        %condicion de parada basada en la diferencia absoluta
        if abs(p - p1) < TOL
            fprintf('La raíz aproximada es: %.5f después de %d iteraciones.', p, i);
            return
        end
        
        i = i + 1;
        
        q = f(p);
        
        %actualizar los puntos p0 y p1
        if q * q1 < 0
            p0 = p1;
            q0 = q1;
        end
        
        %actualización de p1 y q1
        p1 = p;
        q1 = q;
    end
    
    fprintf('El método falló después de %d iteraciones, N0 = %d.\n', N, N);
    
    end
