function [sizes, ints] = cuadratura_adaptable(f, a, b, TOL, n)
    %se calcula la integral de f entre a y b usando pasos h
    %diferentes usando la TOL como indicador de cortar el
    %intervalo o mantenerlo igual.
    %el array sizes son los tamaños de los intervalos, se cumple que la
    %suma de los tamaños es igual a b-a.
    %de igual manera ints son las integrales en cada intervalo, para tener
    %la integral completa simplemente se tienen que sumar los valores.

    %se crea la formula que se usara para la integral
    s = @(x1,x2) ((x2-x1)/6)*(f(x1) + 4*f(x1+((x2-x1)/2)) + f(x2));

    sizes = [b-a];
    ints = [];
    ai = a;
    bi = b;
    count = 1;
    depth = 1;

    while ai ~= b
        s_ab = s(ai, bi);
        med = (ai+bi)/2;
        if abs(s_ab - (s(ai, med) + s(med, bi))) < TOL || depth == n
            if count < length(sizes)
                count = count + 1;
            end
            
            ints = [ints, s_ab];
            ai = bi;
            bi = bi + sizes(count);

            depth = depth - 1;
        else
            bi = med;
            sizes(count) = sizes(count)/2;
            sizes = [sizes(1:count), sizes(count), ...
                sizes(count+1:length(sizes))];
            depth = depth + 1;
        end
    end
end

