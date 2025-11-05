function [coef, rl, error] = regresion_lineal(xs, y)
    %xs: matriz nxm con n el numero de variables dependientes y m la
    %cantidad de datos
    %y: vector columna de valores y

    %rl: la funcion de la forma
    %y = a0 + a1x1 + a2x2 + ... + anxn
    %coef: vector columna con los coeficientes a0, a1, ..., an
    %error: error estandar de la regresion

    [m, n] = size(xs);

    matriz = zeros(n+1);
    b = zeros(n+1,1);

    matriz(1,1) = m;
    b(1) = sum(y);

    for j = 2:n+1
        matriz(1,j) = sum(xs(:,j-1));
        matriz(j,1) = matriz(1,j);

        b(j) = xs(:,j-1)' * y;

        for i = 2:j
            matriz(i,j) = xs(:,i-1)' * xs(:,j-1);
            matriz(j,i) = matriz(i,j);
        end
    end
    

    coef = solution_LU(matriz, b);
    rl = @(v) coef(1);

    for i = 1:n
        rl = @(v) rl(v) + coef(i+1)*v(i);
    end

    suma = 0;

    for i = 1:m
        suma = suma + (y(i) - rl(xs(i,:)))^2;
    end

    error = sqrt(suma / (m - n - 1));
end