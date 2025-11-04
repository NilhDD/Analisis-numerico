function [L, U] = fact_LU(A)
    [n, m] = size(A);
    if n ~= m
        error("La matriz A debe ser cuadrada");
    end

    L = eye(n);
    U = zeros(n);

    for i = 1:n
        % Calcular elementos de U (fila i)
        for j = i:n
            U(i,j) = A(i,j) - sum(L(i,1:i-1) .* U(1:i-1,j)');
        end

        % Verificar pivote nulo
        if U(i,i) == 0
            error("Factorización imposible: pivote nulo (singularidad)");
        end

        % Calcular elementos de L (columna i)
        for j = i+1:n
            L(j,i) = (A(j,i) - sum(L(j,1:i-1) .* U(1:i-1,i)')) / U(i,i);
        end
    end
end
