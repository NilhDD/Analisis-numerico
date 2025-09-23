function [ts,yts] = metodo_taylor(f, dfs, alpha, a, b, n)
    %se usa para las ecuaciones diferenciales de la forma
    % y'=f(t,y), y(a)=alpha
    %se debe de cumplir que f cumpla la condicion de Lipschitz

    %f es una funcion de dos parametros t, y
    %dfs es un array donde tiene las derivadas de orden superior de f
    %respecto a t
    %alpha es el valor inicial de a
    %a, b son los extremos del intervalo
    %n es el numero de partes en las que se divide el intervalo

    h = (b-a)/n;
    ts = zeros(1,n+1);
    yts = zeros(1, n+1);

    T = @(t,y) f(t,y);

    for i = 1:length(dfs)
        dfi = dfs{i};
        T = @(t,y) T(t,y) + h^(i)./factorial(i+1) .* dfi(t,y);
    end

    ts(1) = a;
    yts(1) = alpha;

    for i = 2:n+1
        ti = a + (i-1)*h;
        yi = yts(i-1);
        ts(i) = ti;
        yts(i) = yi + h*T(ti, yi);
    end
end