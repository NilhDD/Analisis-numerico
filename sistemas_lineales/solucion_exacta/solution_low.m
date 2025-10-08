function x = solution_low(L, b)
    %L es una matriz cuadrada triangular superior
    %b es un vector columna
    %el sistema debe de ser de la forma Lx=b

    n = length(L);
    x = zeros(n, 1);

    for i = 1:n
        x(i) = (b(i) - L(i,1:i)*x(1:i)) / L(i,i);
    end
end