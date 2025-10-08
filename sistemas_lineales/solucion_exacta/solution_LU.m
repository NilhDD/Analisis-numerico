function x = solution_LU(A, b)
    %A es una matriz cuadrada con inversa
    %b es un vector columna

    [L,U] = fact_LU(A);
    y = solution_low(L, b);
    x = solution_up(U, y);
end

