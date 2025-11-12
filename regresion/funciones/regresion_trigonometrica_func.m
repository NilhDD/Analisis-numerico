function SF = regresion_trigonometrica_func(func, a, b, T, n)
    %func:  funcion a aproximar
    %a, b:  extremos del intervalo de la funcion
    %T:     periodo de la funcion
    %n:     grado de la serie

    %SF:    serie de Fourier de grado n

    L = T/2;
    w = 2*pi/T;

    a0 = 1/L * metodo_simpson(func,a,b,500);
    SF = @(x) a0./2;

    an = zeros(n,1);
    bn = zeros(n,1);

    for i = 1:n
        an(i) = 1/L * metodo_simpson(@(x) func(x)*cos(i*w*x),a,b,500);
        bn(i) = 1/L * metodo_simpson(@(x) func(x)*sin(i*w*x),a,b,500);
    end
    k = (1:n)';
    SF = @(x) SF(x) + an'*cos(k.*w.*x) + bn'*sin(k.*w.*x);    
end