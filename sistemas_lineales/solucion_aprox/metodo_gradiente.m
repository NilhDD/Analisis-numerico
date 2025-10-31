function [x, r, iter] = metodo_gradiente(A, b, ini, TOL, N)
    %A: una matriz nxn positiva y simetrica
    %b: un vector nx1
    %ini: es un vector inicial
    %TOL: tolerancia del metodo
    %N: numero de iteraciones maximas

    %inicio de variables
    x = ini;
    r = b - A * x;
    v = r;
    iter = 1;

    %bucle
    while iter < N
        %se calcula el t que minimiza g(x) y se genera el nuevo x con su
        %residuo
        t = (v' * r) / (v' * A * v);
        x = x + t * v;
        r_next = b - A * x;

        if norm(r_next, inf) < TOL
            break;
        end

        %se calcula la nueva direccion v
        s = ((r_next - r)' * r_next) / (r' * r);
        v = r_next + s*v;
        r = r_next;

        iter = iter + 1;
    end
    disp("Se extendio el numero de pasos");
end