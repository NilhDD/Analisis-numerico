function x = solution_up(U, b)
    %U es una matriz cuadrada triangular superior
    %b es un vector columna
    %el sistema debe de ser de la forma Ux=b

    n = length(U);
    x = zeros(n, 1);

    for i = n:-1:1
        x(i) = (b(i) - U(i,i:end)*x(i:end)) / U(i,i);
    end
end

