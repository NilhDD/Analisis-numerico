function P = coeficientes_lagrange(x, y)
    %se calculan los coeficientes del polinomio de interpolacion de Lagrange.
    %x, y son vectores de igual tamaño donde cada punto es la pareja (xi,yi)
    %P es un vector fila (1xn) que contiene los coeficientes del polinomio
    %ordenados de la potencia más alta a la más baja.

    %validacion de entradas
    if length(x) ~= length(y)
        fprintf('Los vectores de entrada x e y deben tener la misma longitud.');
        return
    end
    
    n = length(x);
    
    %Se define una matriz nxn donde la fila i de L tiene los coeficientes del polinomio base L_i(x)
    %el polinomio tiene grado n-1, por lo que necesita n coeficientes.
    L = zeros(n, n);

    %itera sobre cada punto para construir su polinomio base L_i(x)
    for i = 1:n
        %inicializa el polinomio base para L_i(x)
        %impezamos con el polinomio '1' para poder usar conv()
        Li = 1;
        
        %construye el numerador del polinomio base L_i(x)
        for j = 1:n
            if i ~= j
                %multiplica por el término (x - x_j)
                %la lista [1, -x(j)] representa (x - x_j)
                Li = conv(Li, [1, -x(j)]);
                
                %divide por (x_i - x_j)
                Li = Li / (x(i) - x(j));
            end
        end
        
        % Almacena los coeficientes de L_i(x) en la fila i de la matriz L
        L(i, :) = Li;
    end
    
    % P(x) = sum_{i=1 to n} y_i * L_i(x)
    % Esto se logra multiplicando el vector y por la matriz de coeficientes L
    P = y * L;
end