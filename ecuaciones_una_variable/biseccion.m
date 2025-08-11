function p = biseccion(f, a, b, TOL, N)
    %grafica
    xi = a - 2 : 1e-3 : b + 2;
    y = f(xi);
    plot(xi, y);
    grid on;


    %inicializacion
    i = 1;
    FA = f(a);
    p = a;

    while i <= N
        %guardar el valor de p
        p_old = p;

        %calculo del punto medio
        p = (a + b)/2;
        FP = f(p);

        %condicion de parada
        if FP == 0 || abs(p - p_old) < TOL
            fprintf('La raíz aproximada es %.5f y con %d iteraciones', p, i)
            return
        end
        
        i = i + 1;

        % actualizar los valores de a o b
        if FA * FP > 0
            a = p;
            FA = FP;
        else 
            b = p;
        end
    end
    fprintf('El método falló despues del maximo de iteraciones');
end