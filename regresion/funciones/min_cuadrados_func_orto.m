function [coef, fun] = min_cuadrados_func_orto(f, B, w, a, b)
    %f:     funcion objetivo
    %B:     array base de funciones ortogonales de la forma {g0,g1,...,gn}
    %w:     funcion de peso, definida en a, b
    %a, b:  intervalo de la funcion

    %coef:  vector columna con los coeficientes a0, a1, a2, ..., an
    %func:  funcion de la forma
    %f = a0*g0 + a1*g1 + a2*g2 + ... + an*gn

    %se calcula el polinomio de grado N tal que minimiza el error, usando
    %como base B

    N = length(B);
    coef = zeros(N, 1);

    fun = @(x) 0;

    for i = 1:N
        phi = B{i};
        coef(i) = metodo_simpson(@(x) w(x)*f(x)*phi(x), a, b, 500)/...
            metodo_simpson(@(x) w(x)*phi(x)^2, a, b, 500);
        fun = @(x) fun(x) + coef(i)*phi(x);
    end
end