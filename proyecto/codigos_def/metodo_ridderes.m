function val = metodo_ridderes(f, x0, h, c, n)
    %Se crea una tabla nxn donde n es el numero de columnas de
    %modo que las el error es O(h^(2*(n+1)))
    tabla = zeros(n);

    %inicializar la primera columna con la formula de punto medio
    %de tres puntos
    for i = 1:n
        tabla(i, 1) = 1/(2*(h/(c^i))) * (f(x0+(h/(c^i))) - f(x0-(h/(c^i))));
    end

    %paso inductivo
    for m = 2:n
        for i = 1:n-m+1
            tabla(i, m) = (c^2*tabla(i+1,m-1) - tabla(i,m-1))/(c^2-1);
        end
    end
    val = tabla(1,end);
end