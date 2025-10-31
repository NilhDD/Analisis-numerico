function x = metodo_gauss_seidel(A, b, TOL, N)
    %A es una matriz cuadrada con inversa y numero espectral < 1
    %b es un vector columna
    %TOL: tolerancia del metodo
    %N: numero de iteraciones maximas

    n = length(A);
    x0 = zeros(n,1);
    x = zeros(n,1);
    k = 0;


    while k < N
        for i = 1:n
            x(i) = 1/A(i,i) * (b(i)-[A(i,1:i-1), A(i,i+1:end)] * ...
                [x(1:i-1);x0(i+1:end)]);
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

