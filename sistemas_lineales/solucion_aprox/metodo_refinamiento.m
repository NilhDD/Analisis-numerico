function [xx, COND] = metodo_refinamiento(A, b, ini, N)
    %A: una matriz nxn positiva y simetrica
    %b: un vector nx1
    %x0: es un vector inicial
    %TOL: tolerancia del metodo
    %N: numero de iteraciones maximas

    %este metodo se usa normalmente cuando ya se tiene calculada una
    %solucion y se quiere refinar

    %inicializacion
    n = size(A, 1);
    xx = zeros(n, 1);
    x = ini;

    [L, U, P] = lu(A);

    
    k = 1;
    while k <= N
        %calculo de residual inicial
        r = b - A * x;

        %resolver Ay = r usando LU
        y = U \ (L \ (P * r));
        xx = x + y;
        
        %calculo de numero de condicion de A
        if k == 1
            COND = norm(y, inf) / norm(xx, inf) * 10^16;
        end

        x = xx;
        k = k + 1;
    end

    if k > N
        disp("Se extendio el numero de pasos");
    end
end