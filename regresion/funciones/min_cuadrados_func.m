function [coef, fun] = min_cuadrados_func(f, a, b, N)
    %f:     funcion objetivo
    %a, b:  intervalo de la funcion
    %N:     grado del polinomio

    %coef:  vector columna con los coeficientes a0, a1, a2, ..., an
    %func:  funcion de la forma
    %f = a0 + a1*x + a2*x^2 + ... + an*x^n

    %se calcula el polinomio de grado N tal que minimiza el error, usando
    %como base {x^i}

    ints = zeros(2*N+1, 1);

    for i = 0:2*N
        ints(i+1) = metodo_simpson(@(x) x^i,a,b,500);
    end

    A = zeros(N+1, N+1);
    t = zeros(N+1,1);

    for i = 0:N
        t(i+1) = metodo_simpson(@(x) (x^i)*f(x), a, b, 500);
        for j = 0:N
            A(i+1,j+1) = ints(i+j+1);
        end
    end

    coef = solution_LU(A, t);
    fun = @(x) coef(1);

    for i = 1:N
        fun = @(x) fun(x) + coef(i+1)*x.^i;
    end

end