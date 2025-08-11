function x = RTSafe(f, df, x1, x2, TOL, N)
    %grafica
    xi = x1 - 2 : 1e-3 : x2 + 2;
    y = f(xi);
    plot(xi, y);
    grid on;

    %evaluar la funcion en extremos
    fx1 = f(x1);
    fx2 = f(x2);

    %verificar que se puede usar biseccion
    if fx1 * fx2 > 0
        fprintf('Error: La raiz no esta contenida');
        return
    end

    %verificar criterio de parada en extremos
    if abs(fx1) < TOL
        x = x1;
        return
    elseif abs(fx2) < TOL
        x = x2;
        return
    end

    %inicializacion para el algoritmo
    xl = x1;
    xh = x2;

    rts = (x1+x2)/2;
    dx = abs(x1-x2);
    frts = f(rts);
    dfrts = df(rts);
    i = 0;

    while i <= N
        if rts < xl || xh < rts || abs(dfrts) <= 1e-4
            %biseccion
            dx = (xh - xl)/2;
            rts = xl + dx;
        else
            %newton-raphson
            dx = frts/dfrts;
            rts = rts - dx;
        end

        if abs(dx) < TOL
            x = rts;
            fprintf(['La raíz aproximada es: %.5f después de %d iteraciones.', '\n'], x, i)
            return
        end

        frts = f(rts);
        dfrts = df(rts);

        if frts*f(xh) < 0
            xl = rts;
        else
            xh = rts;
        end

        i = i+1;
    end

    fprintf('Error: No converge despues de N')
end