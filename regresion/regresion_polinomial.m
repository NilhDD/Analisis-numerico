function [coef, rl, error] = regresion_polinomial(x, y, N)
    %x: vector columna de valores x
    %y: vector columna de valores y
    %N: grado del polinomio

    %rl: la funcion de la forma
    %y = a0 + a1x + a2x^2 + ... + anx^n
    %coef: vector columna con los coeficientes a0, a1, ..., an
    %error: error estandar de la regresion

    xs = zeros(length(x), N);
    xs(:,1) = x;

    for i = 2:N
        xs(:,i) = x.^i;
    end

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

    disp(matriz);
    

    coef = solution_LU(matriz, b);
    rl = @(x) coef(1);

    for i = 1:n
        rl = @(x) rl(x) + coef(i+1)*x.^i;
    end

    error = sqrt(sum((y - rl(x)).^2) / (m - n - 1));
end