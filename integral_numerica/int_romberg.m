function tabla = int_romberg(f, a, b, n)
    %Se calcula la integral de f entre a y b, con un error de
    %orden O(h^(2*(n+1)))

    %Se crea una tabla nxn
    tabla = zeros(n);

    %inicializar la primera columna con la formula de punto medio
    %de tres puntos
    hi = (b-a);
    for i = 1:n
        hi = hi/2;
        suma = 0;
        for j = a:2*hi:b
            suma = suma + f(j);
        end
        tabla(i, 1) = hi * (2*suma-(f(a)+f(b)));
    end

    %paso inductivo
    for m = 2:n
        for i = 1:n-m+1
            tabla(i, m) = tabla(i+1,m-1) + (tabla(i+1,m-1) - tabla(i,m-1))/(4^(m-1)-1);
        end
    end
end