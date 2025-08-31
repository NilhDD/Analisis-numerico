function tabla = metodo_ridderes(x0, f, h, c, TOL, n)
    %inicializacion, se calcula el tamaño de la tabla usando
    %la tolerancia y el paso o en otro caso determinando el
    % orden del error segun el paso.
    len = min(ceil(log(h/TOL)/log(c)), ceil(log(n)/log(2)));
    tabla = zeros(len);

    %inicializar la primera columna con la formula de punto medio
    %de tres puntos
    for i = 1:len
        tabla(i, 1) = 1/(2*(h/(c^i))) * (f(x0+(h/(c^i))) - f(x0-(h/(c^i))));
    end

    %paso inductivo
    for m = 2:len
        for n = 1:len-m+1
            tabla(n, m) = (c^2*tabla(n+1,m-1) - tabla(n,m-1))/(c^2-1);
        end
    end
end