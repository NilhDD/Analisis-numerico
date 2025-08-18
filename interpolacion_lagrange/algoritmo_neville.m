function tabla = algoritmo_neville(xa, ya, x, n)
    %Se calcula la Pn(x) donde Pn es el polinomio interpolador de Lagrange
    %para los puntos (xa, ya) ya que directamente calcular el polinomio
    %y evaluar tiene mayor complejidad

    %validacion de entradas
    if length(xa) ~= length(ya)
        fprintf('Los vectores de entrada x e y deben tener la misma longitud.');
        return
    elseif n >= length(xa)
        fprintf('EL grado debe ser menor o igual que el numero de puntos menos 1.');
        return
    end

    len = length(xa);

    %creacion de la tabla
    tabla = zeros(len, n+1);
    tabla(:,1) = ya;

    for m = 2:n+1
        for i = 1:len-m+1
            tabla(i,m) = ((x-xa(i+m-1))*tabla(i,m-1)-(x-xa(i))*tabla(i+1,m-1))/(xa(i)-xa(i+m-1));
        end
    end
end