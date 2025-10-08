function x = metodo_jacobi(A, b, TOL, N)
    %A es una matriz cuadrada con inversa
    %b es un vector columna

    n = length(A);
    x0 = zeros(n,1);
    x = zeros(n,1);
    k = 0;


    while k < N
        for i = 1:n
            x(i) = 1/A(i,i) * (b(i)-[A(i,1:i-1), A(i,i+1:end)] * ...
                [x0(1:i-1);x0(i+1:end)]);
        end

        if metric(x, x0) < TOL
            return;
        end

        k = k+1;
        x0 = x;
    end
    disp("Se extendio el numero de pasos");
    return;
end



function value = metric(x1, x2)
    value = max(x1-x2);
end

