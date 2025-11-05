function [coef, func, k] = regresion_no_lineal(x, y, f, dps, ini, TOL, N)
    %x: vector columna de valores x
    %y: vector columna de valores y
    %f: funcion f(x, {ai})
    %dps: array de derivadas parciales con respecto a ai
    %ini: valor inicial en vector para los coeficientes {ai}
    %TOL: tolerancia del metodo
    %N: numero de iteraciones maximas
    
    %coef: vector columna con los coeficientes a0, a1, ..., an
    %fun: la funcion de la forma y = f(x, {ai}), con ai constantes
    %k: numero de iteraciones requeridas

    n = length(ini);
    m = length(x);
    Z = zeros(m, n);
    coef = ini;

    k = 1;

    while k < N
        for i = 1:n
            dfi = dps{i};
            Z(:,i) = dfi(x, coef);
        end

        D = y - f(x, coef);
        delta = solution_LU(Z'*Z, Z'*D);
        coef = coef + delta;

        if norm(delta, inf)/norm(coef, inf) < TOL
            func = @(t) f(t, coef);
            return
        end
        k = k+1;
    end
    error("Se superan las iteraciones");
end