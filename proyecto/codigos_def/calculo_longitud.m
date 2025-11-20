function val = calculo_longitud(fun_x, fun_y, fun_z)
    %fun_x: funcion en la coordenada x, dominio [0,1]
    %fun_y: funcion en la coordenada y, dominio [0,1]
    %fun_z: funcion en la coordenada z, dominio [0,1]

    %val:   longitud de la curva de la forma
    % val = int_{0}^{1}{||alpha'(t)||dt}

    %definir el operador derivada
    derivada = @(f,t) metodo_ridderes(f,t,1e-6,2,5);

    %calcular las derivadas de cada funcion
    dfx = @(t) derivada(fun_x, t);
    dfy = @(t) derivada(fun_y, t);
    dfz = @(t) derivada(fun_z, t);

    %calcular funcion a integral
    func_int = @(t) sqrt(dfx(t).^2 + dfy(t).^2 + dfz(t).^2);

    %calcular la integral
    [~, ints] = cuadratura_adaptable(func_int, 0, 1, 1e-6, 1e10);
    val = sum(ints);
end