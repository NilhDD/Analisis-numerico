function [L, U] = fact_LU(A)
    [n, m] = size(A);
    if n ~= m
        disp("La matriz A debe se cuadrada");
        return;
    end

    L = zeros(n);
    U = zeros(n);

    L(1,1) = 1;
    U(1,:) = A(1, :);

    for j = 2:n
        U(1,j) = A(1,j) / L(1,1);
        L(j,1) = A(j,1) / U(1,1);
    end

    for i = 2:n-1
        for k = 1:i-1
            L(i,i) = 1;
            U(i,i) = A(i,i) - sum(L(i,1:k) .* U(1:k,i)');
        end

        if U(i,i) == 0
            disp("Factorizacion imposible");
            return;
        end

        for j = i+1:n
            U(i,j) = (A(i,j) - sum(L(i,1:i-1) .* U(1:i-1,j)')) / L(i,i);
            L(j,i) = (A(j,i) - sum(L(j,1:i-1) .* U(1:i-1,i)')) / U(i,i);
        end

        L(n,n) = 1;
        U(n,n) = A(n,n) - sum(L(n,1:n-1) .*  U(1:n-1,n)');

        if U(n,n) == 0
            disp("La matriz es singular");
            return;
        end
    end
end

